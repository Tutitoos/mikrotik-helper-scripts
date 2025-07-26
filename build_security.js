const fs = require("node:fs");
const config = require("./data/security_alert.json");

const OUTPUT_FILE = "./builds/security_alert_scripts.rsc";

function escapeString(str) {
	return str.replace(/\\/g, "\\\\").replace(/\$/g, "\\$").replace(/"/g, '\\"');
}

function buildScript(alert) {
	const { type, name, script, ports } = alert;
  const threshold = 5;

	const baseVars = `:local botToken [/system script environment get [find name="botToken"] value]
:local chatID [/system script environment get [find name="chatID"] value]
:local name "${name}"
:local date [/system clock get date]
:local time [/system clock get time]
`;

	let body = "";
	switch (type) {
		case "login_fail":
			body = `:log warning "🔐 Demasiados intentos de login fallidos"
${baseVars}:local message ("🔐 Se detectaron más de ${threshold} intentos fallidos de acceso en los últimos minutos.%0AFecha: " . $date . " " . $time)
:local url ("https://api.telegram.org/bot" . $botToken . "/sendMessage?chat_id=" . $chatID . "&text=" . $message)
/tool fetch url=$url keep-result=no`;
			break;

		case "port_scan":
			body = `:log warning "🔐 Escaneo de puertos detectado"
${baseVars}:local message ("🔐 Se ha detectado un escaneo de puertos en el router.%0AFecha: " . $date . " " . $time)
:local url ("https://api.telegram.org/bot" . $botToken . "/sendMessage?chat_id=" . $chatID . "&text=" . $message)
/tool fetch url=$url keep-result=no`;
			break;

		case "suspicious_ports": {
			const portsStr = ports.join(", ");
			body = `:log warning "🔐 Actividad sospechosa en puertos comunes"
${baseVars}:local message ("🔐 Se detectó actividad sospechosa en puertos comunes (${portsStr})%0AFecha: " . $date . " " . $time)
:local url ("https://api.telegram.org/bot" . $botToken . "/sendMessage?chat_id=" . $chatID . "&text=" . $message)
/tool fetch url=$url keep-result=no`;
			break;
		}

		default:
			console.warn(`⚠️ Tipo de alerta no reconocida: ${type}`);
			return "";
	}

	return `
/system script remove [find name="${script}"]
/system script add name=${script} policy=read,write,policy source="${escapeString(body)}"`;
}

function buildFirewall(alert) {
	const { type, script, ports } = alert;

	switch (type) {
		case "login_fail":
			// Usamos logging por sistema
			return `
# Firewall rule for ${type}
/ip firewall filter add chain=input protocol=tcp dst-port=22,8291 action=add-src-to-address-list \
address-list=login_fail_list address-list-timeout=10m \
connection-state=new log=yes log-prefix="LOGIN-FAIL"
/system scheduler remove [find name="${script}_trigger"]
/system scheduler add name=${script}_trigger interval=5m on-event="/system script run ${script}" policy=read,write,policy`;

		case "port_scan":
			return `
# Firewall rule for ${type}
/ip firewall raw add chain=prerouting protocol=tcp tcp-flags=fin,syn,rst,psh,ack,urg,ece, cwr \
action=add-src-to-address-list address-list=port_scan_list address-list-timeout=10m log=yes log-prefix="PORT-SCAN"
/system scheduler remove [find name="${script}_trigger"]
/system scheduler add name=${script}_trigger interval=5m on-event="/system script run ${script}" policy=read,write,policy`;

		case "suspicious_ports": {
			const portList = ports.join(",");
			return `
# Firewall rule for ${type}
/ip firewall filter add chain=input protocol=tcp dst-port=${portList} \
action=add-src-to-address-list address-list=suspicious_ports_list address-list-timeout=5m \
log=yes log-prefix="SUS-PORT"
/system scheduler remove [find name="${script}_trigger"]
/system scheduler add name=${script}_trigger interval=5m on-event="/system script run ${script}" policy=read,write,policy`;
		}

		default:
			return "";
	}
}

function buildAllSecurityScripts() {
	let output = "# Security Alert Scripts\n";

	for (const alert of config) {
		const scriptBlock = buildScript(alert);
		const firewallBlock = buildFirewall(alert);
		if (scriptBlock) {
			output += `\n\n# --- ${alert.name} ---\n${scriptBlock}`;
		}
		if (firewallBlock) {
			output += `\n${firewallBlock}`;
		}
	}

	if (!fs.existsSync("./builds")) {
		fs.mkdirSync("./builds", { recursive: true });
	}

	fs.writeFileSync(OUTPUT_FILE, output.trim(), "utf8");
	console.log(`✅ Security scripts & firewall rules saved to ${OUTPUT_FILE}`);
}

buildAllSecurityScripts();
