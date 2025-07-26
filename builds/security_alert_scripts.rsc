# Security Alert Scripts


# --- Login Fail Alert ---
/system script remove [find name="security_login_fail_check"]
/system script add name=security_login_fail_check policy=read,write,policy,test source=":log warning \"🔐 Demasiados intentos de login fallidos\";
:local botToken [/system script environment get [find name=\\\"botToken\\\"] value]
:local chatID [/system script environment get [find name=\\\"chatID\\\"] value]
:local message (\"🚨 Se detectaron más de 5 intentos fallidos en 00:10:00.%0AFecha: \" . [/system clock get date] . \" \" . [/system clock get time])
:local url (\"https://api.telegram.org/bot\" . \$botToken . \"/sendMessage?chat_id=\" . \$chatID . \"&text=\" . \$message)
/tool fetch url=\$url keep-result=no"

# --- Port Scan Alert ---
/system script remove [find name="security_port_scan_check"]
/system script add name=security_port_scan_check policy=read,write,policy,test source=":log warning \"🔐 Escaneo de puertos detectado\";
:local botToken [/system script environment get [find name=\\\"botToken\\\"] value]
:local chatID [/system script environment get [find name=\\\"chatID\\\"] value]
:local message (\"🚨 Posible escaneo de puertos detectado desde la red interna.%0AFecha: \" . [/system clock get date] . \" \" . [/system clock get time])
:local url (\"https://api.telegram.org/bot\" . \$botToken . \"/sendMessage?chat_id=\" . \$chatID . \"&text=\" . \$message)
/tool fetch url=\$url keep-result=no"

# --- Suspicious Port Activity ---
/system script remove [find name="security_suspicious_ports_check"]
/system script add name=security_suspicious_ports_check policy=read,write,policy,test source=":log warning \"🔐 Actividad sospechosa en puertos comunes\";
:local botToken [/system script environment get [find name=\\\"botToken\\\"] value]
:local chatID [/system script environment get [find name=\\\"chatID\\\"] value]
:local message (\"🚨 Se detectó tráfico sospechoso en puertos comunes (21, 22, 23, 445, 3389, 8006).%0AFecha: \" . [/system clock get date] . \" \" . [/system clock get time])
:local url (\"https://api.telegram.org/bot\" . \$botToken . \"/sendMessage?chat_id=\" . \$chatID . \"&text=\" . \$message)
/tool fetch url=\$url keep-result=no"