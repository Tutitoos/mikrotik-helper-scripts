# Global variables
:global botToken [/system script environment get [find name="botToken"] value]
:global chatID [/system script environment get [find name="chatID"] value]

# --- AdGuard (94.140.14.14) ---
/system script remove [find name="adguard_alert_check"]
/system script add name=adguard_alert_check policy=read,write,policy source=":log warning \"Netwatch disparo adguard_alert_check\";
:global botToken
:global chatID
:local name \"AdGuard\"
:local ip \"94.140.14.14\"
:local date [/system clock get date]
:local time [/system clock get time]
:local status \"\"
:local isUp [/ping \$ip count=2]
:if (\$isUp = 0) do={ :set status \"Caido\" } else={ :set status \"En linea\" }
:local message (\"Servicio:%20\" . \$name . \"%0AIP:%20\" . \$ip . \"%0AEstado:%20\" . \$status . \"%0AFecha:%20\" . \$date . \"%0AHora:%20\" . \$time)
:local url (\"https://api.telegram.org/bot\" . \$botToken . \"/sendMessage?chat_id=\" . \$chatID . \"&text=\" . \$message)
:log info (\"[DEBUG] Estado: \" . \$status . \", IP: \" . \$ip)
:log warning \$url
/tool fetch url=\$url keep-result=no"

/system script remove [find name="adguard_alert_down"]
/system script add name=adguard_alert_down policy=read,write,policy source=":log warning \"Netwatch disparo adguard_alert_down\";
:global botToken
:global chatID
:local name \"AdGuard\"
:local ip \"94.140.14.14\"
:local date [/system clock get date]
:local time [/system clock get time]
:local status \"Caido\"
:local message (\"Servicio:%20\" . \$name . \"%0AIP:%20\" . \$ip . \"%0AEstado:%20\" . \$status . \"%0AFecha:%20\" . \$date . \"%0AHora:%20\" . \$time)
:local url (\"https://api.telegram.org/bot\" . \$botToken . \"/sendMessage?chat_id=\" . \$chatID . \"&text=\" . \$message)
/tool fetch url=\$url keep-result=no"

/system script remove [find name="adguard_alert_up"]
/system script add name=adguard_alert_up policy=read,write,policy source=":log warning \"Netwatch disparo adguard_alert_up\";
:global botToken
:global chatID
:local name \"AdGuard\"
:local ip \"94.140.14.14\"
:local date [/system clock get date]
:local time [/system clock get time]
:local status \"Recuperado\"
:local message (\"Servicio:%20\" . \$name . \"%0AIP:%20\" . \$ip . \"%0AEstado:%20\" . \$status . \"%0AFecha:%20\" . \$date . \"%0AHora:%20\" . \$time)
:local url (\"https://api.telegram.org/bot\" . \$botToken . \"/sendMessage?chat_id=\" . \$chatID . \"&text=\" . \$message)
/tool fetch url=\$url keep-result=no"

# Netwatch
/tool netwatch remove [find host="94.140.14.14"]
/tool netwatch add host=94.140.14.14 interval=00:00:30 timeout=5s comment="Monitoreo AdGuard 94.140.14.14" down="/system script run adguard_alert_down" up="/system script run adguard_alert_up"

# Scheduler
/system scheduler remove [find name="adguard_alert_check_schedule"]
/system scheduler add name=adguard_alert_check_schedule start-date=2025-07-24 start-time=14:25:08 interval=08:00:00 on-event="/system script run adguard_alert_check"

# --- AdGuard (94.140.15.15) ---
/system script remove [find name="adguard_alt_alert_check"]
/system script add name=adguard_alt_alert_check policy=read,write,policy source=":log warning \"Netwatch disparo adguard_alt_alert_check\";
:global botToken
:global chatID
:local name \"AdGuard\"
:local ip \"94.140.15.15\"
:local date [/system clock get date]
:local time [/system clock get time]
:local status \"\"
:local isUp [/ping \$ip count=2]
:if (\$isUp = 0) do={ :set status \"Caido\" } else={ :set status \"En linea\" }
:local message (\"Servicio:%20\" . \$name . \"%0AIP:%20\" . \$ip . \"%0AEstado:%20\" . \$status . \"%0AFecha:%20\" . \$date . \"%0AHora:%20\" . \$time)
:local url (\"https://api.telegram.org/bot\" . \$botToken . \"/sendMessage?chat_id=\" . \$chatID . \"&text=\" . \$message)
:log info (\"[DEBUG] Estado: \" . \$status . \", IP: \" . \$ip)
:log warning \$url
/tool fetch url=\$url keep-result=no"

/system script remove [find name="adguard_alt_alert_down"]
/system script add name=adguard_alt_alert_down policy=read,write,policy source=":log warning \"Netwatch disparo adguard_alt_alert_down\";
:global botToken
:global chatID
:local name \"AdGuard\"
:local ip \"94.140.15.15\"
:local date [/system clock get date]
:local time [/system clock get time]
:local status \"Caido\"
:local message (\"Servicio:%20\" . \$name . \"%0AIP:%20\" . \$ip . \"%0AEstado:%20\" . \$status . \"%0AFecha:%20\" . \$date . \"%0AHora:%20\" . \$time)
:local url (\"https://api.telegram.org/bot\" . \$botToken . \"/sendMessage?chat_id=\" . \$chatID . \"&text=\" . \$message)
/tool fetch url=\$url keep-result=no"

/system script remove [find name="adguard_alt_alert_up"]
/system script add name=adguard_alt_alert_up policy=read,write,policy source=":log warning \"Netwatch disparo adguard_alt_alert_up\";
:global botToken
:global chatID
:local name \"AdGuard\"
:local ip \"94.140.15.15\"
:local date [/system clock get date]
:local time [/system clock get time]
:local status \"Recuperado\"
:local message (\"Servicio:%20\" . \$name . \"%0AIP:%20\" . \$ip . \"%0AEstado:%20\" . \$status . \"%0AFecha:%20\" . \$date . \"%0AHora:%20\" . \$time)
:local url (\"https://api.telegram.org/bot\" . \$botToken . \"/sendMessage?chat_id=\" . \$chatID . \"&text=\" . \$message)
/tool fetch url=\$url keep-result=no"

# Netwatch
/tool netwatch remove [find host="94.140.15.15"]
/tool netwatch add host=94.140.15.15 interval=00:00:30 timeout=5s comment="Monitoreo AdGuard 94.140.15.15" down="/system script run adguard_alt_alert_down" up="/system script run adguard_alt_alert_up"

# Scheduler
/system scheduler remove [find name="adguard_alt_alert_check_schedule"]
/system scheduler add name=adguard_alt_alert_check_schedule start-date=2025-07-24 start-time=14:25:08 interval=08:00:00 on-event="/system script run adguard_alt_alert_check"

# --- Cloudflare (1.1.1.1) ---
/system script remove [find name="cloudflare_alert_check"]
/system script add name=cloudflare_alert_check policy=read,write,policy source=":log warning \"Netwatch disparo cloudflare_alert_check\";
:global botToken
:global chatID
:local name \"Cloudflare\"
:local ip \"1.1.1.1\"
:local date [/system clock get date]
:local time [/system clock get time]
:local status \"\"
:local isUp [/ping \$ip count=2]
:if (\$isUp = 0) do={ :set status \"Caido\" } else={ :set status \"En linea\" }
:local message (\"Servicio:%20\" . \$name . \"%0AIP:%20\" . \$ip . \"%0AEstado:%20\" . \$status . \"%0AFecha:%20\" . \$date . \"%0AHora:%20\" . \$time)
:local url (\"https://api.telegram.org/bot\" . \$botToken . \"/sendMessage?chat_id=\" . \$chatID . \"&text=\" . \$message)
:log info (\"[DEBUG] Estado: \" . \$status . \", IP: \" . \$ip)
:log warning \$url
/tool fetch url=\$url keep-result=no"

/system script remove [find name="cloudflare_alert_down"]
/system script add name=cloudflare_alert_down policy=read,write,policy source=":log warning \"Netwatch disparo cloudflare_alert_down\";
:global botToken
:global chatID
:local name \"Cloudflare\"
:local ip \"1.1.1.1\"
:local date [/system clock get date]
:local time [/system clock get time]
:local status \"Caido\"
:local message (\"Servicio:%20\" . \$name . \"%0AIP:%20\" . \$ip . \"%0AEstado:%20\" . \$status . \"%0AFecha:%20\" . \$date . \"%0AHora:%20\" . \$time)
:local url (\"https://api.telegram.org/bot\" . \$botToken . \"/sendMessage?chat_id=\" . \$chatID . \"&text=\" . \$message)
/tool fetch url=\$url keep-result=no"

/system script remove [find name="cloudflare_alert_up"]
/system script add name=cloudflare_alert_up policy=read,write,policy source=":log warning \"Netwatch disparo cloudflare_alert_up\";
:global botToken
:global chatID
:local name \"Cloudflare\"
:local ip \"1.1.1.1\"
:local date [/system clock get date]
:local time [/system clock get time]
:local status \"Recuperado\"
:local message (\"Servicio:%20\" . \$name . \"%0AIP:%20\" . \$ip . \"%0AEstado:%20\" . \$status . \"%0AFecha:%20\" . \$date . \"%0AHora:%20\" . \$time)
:local url (\"https://api.telegram.org/bot\" . \$botToken . \"/sendMessage?chat_id=\" . \$chatID . \"&text=\" . \$message)
/tool fetch url=\$url keep-result=no"

# Netwatch
/tool netwatch remove [find host="1.1.1.1"]
/tool netwatch add host=1.1.1.1 interval=00:00:30 timeout=5s comment="Monitoreo Cloudflare 1.1.1.1" down="/system script run cloudflare_alert_down" up="/system script run cloudflare_alert_up"

# Scheduler
/system scheduler remove [find name="cloudflare_alert_check_schedule"]
/system scheduler add name=cloudflare_alert_check_schedule start-date=2025-07-24 start-time=14:25:08 interval=08:00:00 on-event="/system script run cloudflare_alert_check"

# --- Cloudflare (1.0.0.1) ---
/system script remove [find name="cloudflare_alt_alert_check"]
/system script add name=cloudflare_alt_alert_check policy=read,write,policy source=":log warning \"Netwatch disparo cloudflare_alt_alert_check\";
:global botToken
:global chatID
:local name \"Cloudflare\"
:local ip \"1.0.0.1\"
:local date [/system clock get date]
:local time [/system clock get time]
:local status \"\"
:local isUp [/ping \$ip count=2]
:if (\$isUp = 0) do={ :set status \"Caido\" } else={ :set status \"En linea\" }
:local message (\"Servicio:%20\" . \$name . \"%0AIP:%20\" . \$ip . \"%0AEstado:%20\" . \$status . \"%0AFecha:%20\" . \$date . \"%0AHora:%20\" . \$time)
:local url (\"https://api.telegram.org/bot\" . \$botToken . \"/sendMessage?chat_id=\" . \$chatID . \"&text=\" . \$message)
:log info (\"[DEBUG] Estado: \" . \$status . \", IP: \" . \$ip)
:log warning \$url
/tool fetch url=\$url keep-result=no"

/system script remove [find name="cloudflare_alt_alert_down"]
/system script add name=cloudflare_alt_alert_down policy=read,write,policy source=":log warning \"Netwatch disparo cloudflare_alt_alert_down\";
:global botToken
:global chatID
:local name \"Cloudflare\"
:local ip \"1.0.0.1\"
:local date [/system clock get date]
:local time [/system clock get time]
:local status \"Caido\"
:local message (\"Servicio:%20\" . \$name . \"%0AIP:%20\" . \$ip . \"%0AEstado:%20\" . \$status . \"%0AFecha:%20\" . \$date . \"%0AHora:%20\" . \$time)
:local url (\"https://api.telegram.org/bot\" . \$botToken . \"/sendMessage?chat_id=\" . \$chatID . \"&text=\" . \$message)
/tool fetch url=\$url keep-result=no"

/system script remove [find name="cloudflare_alt_alert_up"]
/system script add name=cloudflare_alt_alert_up policy=read,write,policy source=":log warning \"Netwatch disparo cloudflare_alt_alert_up\";
:global botToken
:global chatID
:local name \"Cloudflare\"
:local ip \"1.0.0.1\"
:local date [/system clock get date]
:local time [/system clock get time]
:local status \"Recuperado\"
:local message (\"Servicio:%20\" . \$name . \"%0AIP:%20\" . \$ip . \"%0AEstado:%20\" . \$status . \"%0AFecha:%20\" . \$date . \"%0AHora:%20\" . \$time)
:local url (\"https://api.telegram.org/bot\" . \$botToken . \"/sendMessage?chat_id=\" . \$chatID . \"&text=\" . \$message)
/tool fetch url=\$url keep-result=no"

# Netwatch
/tool netwatch remove [find host="1.0.0.1"]
/tool netwatch add host=1.0.0.1 interval=00:00:30 timeout=5s comment="Monitoreo Cloudflare 1.0.0.1" down="/system script run cloudflare_alt_alert_down" up="/system script run cloudflare_alt_alert_up"

# Scheduler
/system scheduler remove [find name="cloudflare_alt_alert_check_schedule"]
/system scheduler add name=cloudflare_alt_alert_check_schedule start-date=2025-07-24 start-time=14:25:08 interval=08:00:00 on-event="/system script run cloudflare_alt_alert_check"

# --- Google (8.8.8.8) ---
/system script remove [find name="google_alert_check"]
/system script add name=google_alert_check policy=read,write,policy source=":log warning \"Netwatch disparo google_alert_check\";
:global botToken
:global chatID
:local name \"Google\"
:local ip \"8.8.8.8\"
:local date [/system clock get date]
:local time [/system clock get time]
:local status \"\"
:local isUp [/ping \$ip count=2]
:if (\$isUp = 0) do={ :set status \"Caido\" } else={ :set status \"En linea\" }
:local message (\"Servicio:%20\" . \$name . \"%0AIP:%20\" . \$ip . \"%0AEstado:%20\" . \$status . \"%0AFecha:%20\" . \$date . \"%0AHora:%20\" . \$time)
:local url (\"https://api.telegram.org/bot\" . \$botToken . \"/sendMessage?chat_id=\" . \$chatID . \"&text=\" . \$message)
:log info (\"[DEBUG] Estado: \" . \$status . \", IP: \" . \$ip)
:log warning \$url
/tool fetch url=\$url keep-result=no"

/system script remove [find name="google_alert_down"]
/system script add name=google_alert_down policy=read,write,policy source=":log warning \"Netwatch disparo google_alert_down\";
:global botToken
:global chatID
:local name \"Google\"
:local ip \"8.8.8.8\"
:local date [/system clock get date]
:local time [/system clock get time]
:local status \"Caido\"
:local message (\"Servicio:%20\" . \$name . \"%0AIP:%20\" . \$ip . \"%0AEstado:%20\" . \$status . \"%0AFecha:%20\" . \$date . \"%0AHora:%20\" . \$time)
:local url (\"https://api.telegram.org/bot\" . \$botToken . \"/sendMessage?chat_id=\" . \$chatID . \"&text=\" . \$message)
/tool fetch url=\$url keep-result=no"

/system script remove [find name="google_alert_up"]
/system script add name=google_alert_up policy=read,write,policy source=":log warning \"Netwatch disparo google_alert_up\";
:global botToken
:global chatID
:local name \"Google\"
:local ip \"8.8.8.8\"
:local date [/system clock get date]
:local time [/system clock get time]
:local status \"Recuperado\"
:local message (\"Servicio:%20\" . \$name . \"%0AIP:%20\" . \$ip . \"%0AEstado:%20\" . \$status . \"%0AFecha:%20\" . \$date . \"%0AHora:%20\" . \$time)
:local url (\"https://api.telegram.org/bot\" . \$botToken . \"/sendMessage?chat_id=\" . \$chatID . \"&text=\" . \$message)
/tool fetch url=\$url keep-result=no"

# Netwatch
/tool netwatch remove [find host="8.8.8.8"]
/tool netwatch add host=8.8.8.8 interval=00:00:30 timeout=5s comment="Monitoreo Google 8.8.8.8" down="/system script run google_alert_down" up="/system script run google_alert_up"

# Scheduler
/system scheduler remove [find name="google_alert_check_schedule"]
/system scheduler add name=google_alert_check_schedule start-date=2025-07-24 start-time=14:25:08 interval=08:00:00 on-event="/system script run google_alert_check"

# --- Google (8.8.4.4) ---
/system script remove [find name="google_alt_alert_check"]
/system script add name=google_alt_alert_check policy=read,write,policy source=":log warning \"Netwatch disparo google_alt_alert_check\";
:global botToken
:global chatID
:local name \"Google\"
:local ip \"8.8.4.4\"
:local date [/system clock get date]
:local time [/system clock get time]
:local status \"\"
:local isUp [/ping \$ip count=2]
:if (\$isUp = 0) do={ :set status \"Caido\" } else={ :set status \"En linea\" }
:local message (\"Servicio:%20\" . \$name . \"%0AIP:%20\" . \$ip . \"%0AEstado:%20\" . \$status . \"%0AFecha:%20\" . \$date . \"%0AHora:%20\" . \$time)
:local url (\"https://api.telegram.org/bot\" . \$botToken . \"/sendMessage?chat_id=\" . \$chatID . \"&text=\" . \$message)
:log info (\"[DEBUG] Estado: \" . \$status . \", IP: \" . \$ip)
:log warning \$url
/tool fetch url=\$url keep-result=no"

/system script remove [find name="google_alt_alert_down"]
/system script add name=google_alt_alert_down policy=read,write,policy source=":log warning \"Netwatch disparo google_alt_alert_down\";
:global botToken
:global chatID
:local name \"Google\"
:local ip \"8.8.4.4\"
:local date [/system clock get date]
:local time [/system clock get time]
:local status \"Caido\"
:local message (\"Servicio:%20\" . \$name . \"%0AIP:%20\" . \$ip . \"%0AEstado:%20\" . \$status . \"%0AFecha:%20\" . \$date . \"%0AHora:%20\" . \$time)
:local url (\"https://api.telegram.org/bot\" . \$botToken . \"/sendMessage?chat_id=\" . \$chatID . \"&text=\" . \$message)
/tool fetch url=\$url keep-result=no"

/system script remove [find name="google_alt_alert_up"]
/system script add name=google_alt_alert_up policy=read,write,policy source=":log warning \"Netwatch disparo google_alt_alert_up\";
:global botToken
:global chatID
:local name \"Google\"
:local ip \"8.8.4.4\"
:local date [/system clock get date]
:local time [/system clock get time]
:local status \"Recuperado\"
:local message (\"Servicio:%20\" . \$name . \"%0AIP:%20\" . \$ip . \"%0AEstado:%20\" . \$status . \"%0AFecha:%20\" . \$date . \"%0AHora:%20\" . \$time)
:local url (\"https://api.telegram.org/bot\" . \$botToken . \"/sendMessage?chat_id=\" . \$chatID . \"&text=\" . \$message)
/tool fetch url=\$url keep-result=no"

# Netwatch
/tool netwatch remove [find host="8.8.4.4"]
/tool netwatch add host=8.8.4.4 interval=00:00:30 timeout=5s comment="Monitoreo Google 8.8.4.4" down="/system script run google_alt_alert_down" up="/system script run google_alt_alert_up"

# Scheduler
/system scheduler remove [find name="google_alt_alert_check_schedule"]
/system scheduler add name=google_alt_alert_check_schedule start-date=2025-07-24 start-time=14:25:08 interval=08:00:00 on-event="/system script run google_alt_alert_check"

# --- Quad9 (9.9.9.9) ---
/system script remove [find name="quad9_alert_check"]
/system script add name=quad9_alert_check policy=read,write,policy source=":log warning \"Netwatch disparo quad9_alert_check\";
:global botToken
:global chatID
:local name \"Quad9\"
:local ip \"9.9.9.9\"
:local date [/system clock get date]
:local time [/system clock get time]
:local status \"\"
:local isUp [/ping \$ip count=2]
:if (\$isUp = 0) do={ :set status \"Caido\" } else={ :set status \"En linea\" }
:local message (\"Servicio:%20\" . \$name . \"%0AIP:%20\" . \$ip . \"%0AEstado:%20\" . \$status . \"%0AFecha:%20\" . \$date . \"%0AHora:%20\" . \$time)
:local url (\"https://api.telegram.org/bot\" . \$botToken . \"/sendMessage?chat_id=\" . \$chatID . \"&text=\" . \$message)
:log info (\"[DEBUG] Estado: \" . \$status . \", IP: \" . \$ip)
:log warning \$url
/tool fetch url=\$url keep-result=no"

/system script remove [find name="quad9_alert_down"]
/system script add name=quad9_alert_down policy=read,write,policy source=":log warning \"Netwatch disparo quad9_alert_down\";
:global botToken
:global chatID
:local name \"Quad9\"
:local ip \"9.9.9.9\"
:local date [/system clock get date]
:local time [/system clock get time]
:local status \"Caido\"
:local message (\"Servicio:%20\" . \$name . \"%0AIP:%20\" . \$ip . \"%0AEstado:%20\" . \$status . \"%0AFecha:%20\" . \$date . \"%0AHora:%20\" . \$time)
:local url (\"https://api.telegram.org/bot\" . \$botToken . \"/sendMessage?chat_id=\" . \$chatID . \"&text=\" . \$message)
/tool fetch url=\$url keep-result=no"

/system script remove [find name="quad9_alert_up"]
/system script add name=quad9_alert_up policy=read,write,policy source=":log warning \"Netwatch disparo quad9_alert_up\";
:global botToken
:global chatID
:local name \"Quad9\"
:local ip \"9.9.9.9\"
:local date [/system clock get date]
:local time [/system clock get time]
:local status \"Recuperado\"
:local message (\"Servicio:%20\" . \$name . \"%0AIP:%20\" . \$ip . \"%0AEstado:%20\" . \$status . \"%0AFecha:%20\" . \$date . \"%0AHora:%20\" . \$time)
:local url (\"https://api.telegram.org/bot\" . \$botToken . \"/sendMessage?chat_id=\" . \$chatID . \"&text=\" . \$message)
/tool fetch url=\$url keep-result=no"

# Netwatch
/tool netwatch remove [find host="9.9.9.9"]
/tool netwatch add host=9.9.9.9 interval=00:00:30 timeout=5s comment="Monitoreo Quad9 9.9.9.9" down="/system script run quad9_alert_down" up="/system script run quad9_alert_up"

# Scheduler
/system scheduler remove [find name="quad9_alert_check_schedule"]
/system scheduler add name=quad9_alert_check_schedule start-date=2025-07-24 start-time=14:25:08 interval=08:00:00 on-event="/system script run quad9_alert_check"

# --- Quad9 (149.112.112.112) ---
/system script remove [find name="quad9_alt_alert_check"]
/system script add name=quad9_alt_alert_check policy=read,write,policy source=":log warning \"Netwatch disparo quad9_alt_alert_check\";
:global botToken
:global chatID
:local name \"Quad9\"
:local ip \"149.112.112.112\"
:local date [/system clock get date]
:local time [/system clock get time]
:local status \"\"
:local isUp [/ping \$ip count=2]
:if (\$isUp = 0) do={ :set status \"Caido\" } else={ :set status \"En linea\" }
:local message (\"Servicio:%20\" . \$name . \"%0AIP:%20\" . \$ip . \"%0AEstado:%20\" . \$status . \"%0AFecha:%20\" . \$date . \"%0AHora:%20\" . \$time)
:local url (\"https://api.telegram.org/bot\" . \$botToken . \"/sendMessage?chat_id=\" . \$chatID . \"&text=\" . \$message)
:log info (\"[DEBUG] Estado: \" . \$status . \", IP: \" . \$ip)
:log warning \$url
/tool fetch url=\$url keep-result=no"

/system script remove [find name="quad9_alt_alert_down"]
/system script add name=quad9_alt_alert_down policy=read,write,policy source=":log warning \"Netwatch disparo quad9_alt_alert_down\";
:global botToken
:global chatID
:local name \"Quad9\"
:local ip \"149.112.112.112\"
:local date [/system clock get date]
:local time [/system clock get time]
:local status \"Caido\"
:local message (\"Servicio:%20\" . \$name . \"%0AIP:%20\" . \$ip . \"%0AEstado:%20\" . \$status . \"%0AFecha:%20\" . \$date . \"%0AHora:%20\" . \$time)
:local url (\"https://api.telegram.org/bot\" . \$botToken . \"/sendMessage?chat_id=\" . \$chatID . \"&text=\" . \$message)
/tool fetch url=\$url keep-result=no"

/system script remove [find name="quad9_alt_alert_up"]
/system script add name=quad9_alt_alert_up policy=read,write,policy source=":log warning \"Netwatch disparo quad9_alt_alert_up\";
:global botToken
:global chatID
:local name \"Quad9\"
:local ip \"149.112.112.112\"
:local date [/system clock get date]
:local time [/system clock get time]
:local status \"Recuperado\"
:local message (\"Servicio:%20\" . \$name . \"%0AIP:%20\" . \$ip . \"%0AEstado:%20\" . \$status . \"%0AFecha:%20\" . \$date . \"%0AHora:%20\" . \$time)
:local url (\"https://api.telegram.org/bot\" . \$botToken . \"/sendMessage?chat_id=\" . \$chatID . \"&text=\" . \$message)
/tool fetch url=\$url keep-result=no"

# Netwatch
/tool netwatch remove [find host="149.112.112.112"]
/tool netwatch add host=149.112.112.112 interval=00:00:30 timeout=5s comment="Monitoreo Quad9 149.112.112.112" down="/system script run quad9_alt_alert_down" up="/system script run quad9_alt_alert_up"

# Scheduler
/system scheduler remove [find name="quad9_alt_alert_check_schedule"]
/system scheduler add name=quad9_alt_alert_check_schedule start-date=2025-07-24 start-time=14:25:08 interval=08:00:00 on-event="/system script run quad9_alt_alert_check"