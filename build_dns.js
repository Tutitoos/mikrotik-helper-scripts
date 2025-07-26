const fs = require("node:fs");
const config = require("./data/dns_alert.json");

const OUTPUT_FILE = "./builds/dns_alert_scripts.rsc";

function escapeString(str) {
  return str
    .replace(/\\/g, '\\\\')       // escapa \
    .replace(/\$/g, '\\$')        // escapa $
    .replace(/"/g, '\\"');        // escapa "
}

function buildScript(dns) {
  const { name, ip, scripts } = dns;
  const baseVars = `:global botToken
:global chatID
:local name "${name}"
:local ip "${ip}"
:local date [/system clock get date]
:local time [/system clock get time]
`;

  return scripts.map(scriptId => {
    let body = "";

    if (scriptId.includes("alert_up")) {
      body = `:log warning "Netwatch disparo ${scriptId}";
${baseVars}:local status "Recuperado"
:local message ("Servicio:%20" . $name . "%0AIP:%20" . $ip . "%0AEstado:%20" . $status . "%0AFecha:%20" . $date . "%0AHora:%20" . $time)
:local url ("https://api.telegram.org/bot" . $botToken . "/sendMessage?chat_id=" . $chatID . "&text=" . $message)
/tool fetch url=$url keep-result=no`;
    } else if (scriptId.includes("alert_down")) {
      body = `:log warning "Netwatch disparo ${scriptId}";
${baseVars}:local status "Caido"
:local message ("Servicio:%20" . $name . "%0AIP:%20" . $ip . "%0AEstado:%20" . $status . "%0AFecha:%20" . $date . "%0AHora:%20" . $time)
:local url ("https://api.telegram.org/bot" . $botToken . "/sendMessage?chat_id=" . $chatID . "&text=" . $message)
/tool fetch url=$url keep-result=no`;
    } else if (scriptId.includes("alert_check")) {
      body = `:log warning "Netwatch disparo ${scriptId}";
${baseVars}:local status ""
:local isUp [/ping $ip count=2]
:if ($isUp = 0) do={ :set status "Caido" } else={ :set status "En linea" }
:local message ("Servicio:%20" . $name . "%0AIP:%20" . $ip . "%0AEstado:%20" . $status . "%0AFecha:%20" . $date . "%0AHora:%20" . $time)
:local url ("https://api.telegram.org/bot" . $botToken . "/sendMessage?chat_id=" . $chatID . "&text=" . $message)
/tool fetch url=$url keep-result=no`;
    }

    return `/system script remove [find name="${scriptId}"]
/system script add name=${scriptId} policy=read,write,policy source="${escapeString(body)}"\n`;
  }).join("\n");
}

function buildNetwatch(dns) {
  const { name, ip, scripts } = dns;
  const downScript = scripts.find(s => s.includes("alert_down"));
  const upScript = scripts.find(s => s.includes("alert_up"));

  return `
/tool netwatch remove [find host="${ip}"]
/tool netwatch add host=${ip} interval=00:00:30 timeout=5s comment="Monitoreo ${name} ${ip}" \
down="/system script run ${downScript}" \
up="/system script run ${upScript}"
`.trim();
}

function buildScheduler(dns) {
  const { scripts } = dns;
  const checkScript = scripts.find(s => s.includes("alert_check"));
  if (!checkScript) return "";

  const schedulerName = `${checkScript}_schedule`;

  return `/system scheduler remove [find name="${schedulerName}"]
/system scheduler add name=${schedulerName} start-date=2025-07-24 start-time=14:25:08 interval=08:00:00 \
on-event="/system script run ${checkScript}"
`.trim();
}

function buildAllScripts() {
  let output = "";

  for (const dns of config) {
    output += `\n\n# --- ${dns.name} (${dns.ip}) ---\n`;
    output += buildScript(dns);
    output += `\n# Netwatch\n${buildNetwatch(dns)}`;
    output += `\n\n# Scheduler\n${buildScheduler(dns)}`;
  }

  if (!fs.existsSync("./builds")) {
    fs.mkdirSync("./builds", { recursive: true });
  }

  fs.writeFileSync(OUTPUT_FILE, output.trim(), "utf8");
  console.log(`✅ All DNS alert scripts saved to ${OUTPUT_FILE}`);
}

buildAllScripts();



