#!/bin/bash

# Definição das variáveis globais
programName="QuickLinux"
developer="$(echo -e "\u00A9") $(date +%Y) - GLOBAL TEC Informática $(echo -e "\u24C7") | www.gti1.com.br"

quickLinuxRoot="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
quickLinuxConfigDir="${quickLinuxRoot}/.quicklinux"
quickLinuxIconsConfig="${quickLinuxConfigDir}/icons.conf"

ql_set_icons() {
    mkdir -p "$quickLinuxConfigDir"
    if [ "$1" = "1" ]; then
        printf '1\n' > "$quickLinuxIconsConfig"
    else
        printf '0\n' > "$quickLinuxIconsConfig"
    fi
}

ql_icons_enabled() {
    [ ! -f "$quickLinuxIconsConfig" ] && return 0
    [ "$(cat "$quickLinuxIconsConfig" 2>/dev/null)" != "0" ]
}

ql_label() {
    local icon="$1"
    local text="$2"

    if ql_icons_enabled; then
        printf '%s  %s' "$icon" "$text"
    else
        printf '%s' "$text"
    fi
}

ql_icons_status_text() {
    if ql_icons_enabled; then
        printf 'Com ícones'
    else
        printf 'Sem ícones'
    fi
}

ql_icons_toggle_text() {
    if ql_icons_enabled; then
        printf 'Desabilitar ícones'
    else
        printf 'Habilitar ícones'
    fi
}
