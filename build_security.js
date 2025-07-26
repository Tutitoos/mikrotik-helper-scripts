const fs = require("node:fs");

const alerts = require("./data/security_alert.json");
const OUTPUT_FILE = "./builds/security_alert_scripts.rsc";

function escapeString(str) {
  return str
    .replace(/\\/g, '\\\\')       // escapa \
    .replace(/\$/g, '\\$')        // escapa $
    .replace(/"/g, '\\"');        // escapa "
}

function buildLoginFail(alert) {
  const script = alert.script;
  const threshold = 5;
  const interval = "00:10:00";

  const body = `:log warning "🔐 Demasiados intentos de login fallidos";
:local botToken [/system script environment get [find name="botToken"] value]
:local chatID [/system script environment get [find name="chatID"] value]
:local message ("🚨 Se detectaron más de ${threshold} intentos fallidos en ${interval}.%0AFecha: " . [/system clock get date] . " " . [/system clock get time])
:local url ("https://api.telegram.org/bot" . $botToken . "/sendMessage?chat_id=" . $chatID . "&text=" . $message)
/tool fetch url=\$url keep-result=no`;

  return `# --- ${alert.name} ---
/system script remove [find name="${script}"]
/system script add name=${script} policy=read,write,policy,test source="${escapeString(body)}"`;
}

function buildPortScan(alert) {
  const script = alert.script || "undefined";

  const body = `:log warning "🔐 Escaneo de puertos detectado";
:local botToken [/system script environment get [find name="botToken"] value]
:local chatID [/system script environment get [find name="chatID"] value]
:local message ("🚨 Posible escaneo de puertos detectado desde la red interna.%0AFecha: " . [/system clock get date] . " " . [/system clock get time])
:local url ("https://api.telegram.org/bot" . $botToken . "/sendMessage?chat_id=" . $chatID . "&text=" . $message)
/tool fetch url=$url keep-result=no`;

  return `# --- ${alert.name} ---
/system script remove [find name="${script}"]
/system script add name=${script} policy=read,write,policy,test source="${escapeString(body)}"`;
}

function buildSuspiciousPorts(alert) {
  const script = alert.script;
  const ports = (alert.ports || []).join(", ");

  const body = `:log warning "🔐 Actividad sospechosa en puertos comunes";
:local botToken [/system script environment get [find name="botToken"] value]
:local chatID [/system script environment get [find name="chatID"] value]
:local message ("🚨 Se detectó tráfico sospechoso en puertos comunes (${ports}).%0AFecha: " . [/system clock get date] . " " . [/system clock get time])
:local url ("https://api.telegram.org/bot" . $botToken . "/sendMessage?chat_id=" . $chatID . "&text=" . $message)
/tool fetch url=$url keep-result=no`;

  return `# --- ${alert.name} ---
/system script remove [find name="${script}"]
/system script add name=${script} policy=read,write,policy,test source="${escapeString(body)}"`;
}

function build() {
  let output = "# Security Alert Scripts\n";

  for (const alert of alerts) {
    let scriptBlock = "";

    switch (alert.type) {
      case "login_fail":
        scriptBlock = buildLoginFail(alert);
        break;
      case "port_scan":
        scriptBlock = buildPortScan(alert);
        break;
      case "suspicious_ports":
        scriptBlock = buildSuspiciousPorts(alert);
        break;
      default:
        console.warn(`⚠️ Tipo de alerta no reconocida: ${alert.type}`);
        continue;
    }

    output += `\n\n${scriptBlock}`;
  }

  if (!fs.existsSync("./builds")) {
    fs.mkdirSync("./builds", { recursive: true });
  }

  fs.writeFileSync(OUTPUT_FILE, output.trim(), "utf8");
  console.log(`✅ Script generado: ${OUTPUT_FILE}`);
}

build();
