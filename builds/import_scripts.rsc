:log warning "Descargando script DNS...";
/tool fetch url="https://raw.githubusercontent.com/Tutitoos/mikrotik-helper-scripts/main/builds/dns_alert_scripts.rsc" \
  dst-path=dns_alert_scripts.rsc mode=https

:delay 1s

:log warning "Importando script DNS...";
/import file-name=dns_alert_scripts.rsc
:log warning "Script DNS importado correctamente";

:delay 2s

:log warning "Descargando script Security...";
/tool fetch url="https://raw.githubusercontent.com/Tutitoos/mikrotik-helper-scripts/main/builds/security_alert_scripts.rsc" \
  dst-path=security_alert_scripts.rsc mode=https

:delay 1s

:log warning "Importando script Security...";
/import file-name=security_alert_scripts.rsc
:log warning "Script Security importado correctamente";
