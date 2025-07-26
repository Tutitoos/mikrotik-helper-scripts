# Security Alert Scripts


# --- Login Fail Alert ---

/system script remove [find name="security_login_fail_check"]
/system script add name=security_login_fail_check policy=read,write,policy source=":log warning \"🔐 Demasiados intentos de login fallidos\"
:local botToken [/system script environment get [find name=\"botToken\"] value]
:local chatID [/system script environment get [find name=\"chatID\"] value]
:local name \"Login Fail Alert\"
:local date [/system clock get date]
:local time [/system clock get time]
:local message (\"🔐 Se detectaron más de 5 intentos fallidos de acceso en los últimos minutos.%0AFecha: \" . \$date . \" \" . \$time)
:local url (\"https://api.telegram.org/bot\" . \$botToken . \"/sendMessage?chat_id=\" . \$chatID . \"&text=\" . \$message)
/tool fetch url=\$url keep-result=no"

# Firewall rule for login_fail
/ip firewall filter add chain=input protocol=tcp dst-port=22,8291 connection-state=new action=add-src-to-address-list address-list=login_fail_list address-list-timeout=10m log=yes log-prefix="LOGIN-FAIL"
/system scheduler remove [find name="security_login_fail_check_trigger"]
/system scheduler add name=security_login_fail_check_trigger interval=5m on-event="/system script run security_login_fail_check" policy=read,write,policy

# --- Port Scan Alert ---

/system script remove [find name="security_port_scan_check"]
/system script add name=security_port_scan_check policy=read,write,policy source=":log warning \"🔐 Escaneo de puertos detectado\"
:local botToken [/system script environment get [find name=\"botToken\"] value]
:local chatID [/system script environment get [find name=\"chatID\"] value]
:local name \"Port Scan Alert\"
:local date [/system clock get date]
:local time [/system clock get time]
:local message (\"🔐 Se ha detectado un escaneo de puertos en el router.%0AFecha: \" . \$date . \" \" . \$time)
:local url (\"https://api.telegram.org/bot\" . \$botToken . \"/sendMessage?chat_id=\" . \$chatID . \"&text=\" . \$message)
/tool fetch url=\$url keep-result=no"

# Firewall rule for port_scan
/ip firewall raw add chain=prerouting protocol=tcp tcp-flags=fin,!syn,!rst,!psh,!ack,!urg action=add-src-to-address-list address-list=port_scan_list address-list-timeout=10m log=yes log-prefix="PORT-SCAN"
/system scheduler remove [find name="security_port_scan_check_trigger"]
/system scheduler add name=security_port_scan_check_trigger interval=5m on-event="/system script run security_port_scan_check" policy=read,write,policy

# --- Suspicious Port Activity ---

/system script remove [find name="security_suspicious_ports_check"]
/system script add name=security_suspicious_ports_check policy=read,write,policy source=":log warning \"🔐 Actividad sospechosa en puertos comunes\"
:local botToken [/system script environment get [find name=\"botToken\"] value]
:local chatID [/system script environment get [find name=\"chatID\"] value]
:local name \"Suspicious Port Activity\"
:local date [/system clock get date]
:local time [/system clock get time]
:local message (\"🔐 Se detectó actividad sospechosa en puertos comunes (21, 22, 23, 445, 3389, 8006)%0AFecha: \" . \$date . \" \" . \$time)
:local url (\"https://api.telegram.org/bot\" . \$botToken . \"/sendMessage?chat_id=\" . \$chatID . \"&text=\" . \$message)
/tool fetch url=\$url keep-result=no"

# Firewall rule for suspicious_ports
/ip firewall filter add chain=input protocol=tcp dst-port=21,22,23,445,3389,8006 action=add-src-to-address-list address-list=suspicious_ports_list address-list-timeout=5m log=yes log-prefix="SUS-PORT"
/system scheduler remove [find name="security_suspicious_ports_check_trigger"]
/system scheduler add name=security_suspicious_ports_check_trigger interval=5m on-event="/system script run security_suspicious_ports_check" policy=read,write,policy