:log warning "Descargando script DNS...";
/tool fetch url="https://raw.githubusercontent.com/Tutitoos/mikrotik-helper-scripts/main/builds/dns_alert_scripts.rsc" \
  dst-path=dns_alert_scripts.rsc mode=https

:delay 1s

:log warning "Importando script DNS...";
/import file-name=dns_alert_scripts.rsc
