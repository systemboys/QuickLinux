#!/bin/bash

# System_Information.sh - Opções para sessão relacionadas à Internet.
#
# Autor: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
# Manutenção: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
#
# ---------------------------------------------------------------
# Este programa tem a finalidade de Opções para sessão relacionadas à Internet.
# ---------------------------------------------------------------
# Histórico:
# v1.0.0 2023-10-29 às 17h00, Marcos Aurélio:
#   - Versão inicial, Opções para sessão relacionadas à Internet.
# v1.0.1 2026-05-03 às 11h55, Marcos Aurélio:
#   - Ajuste no retorno da sessão para preservar a seleção no menu principal.
# v1.0.2 2026-05-03 às 13h20, Marcos Aurélio:
#   - Adicionados ícones aos itens do menu.
#
# Licença: GPL.

# Incluindo o GlobalVariables.sh para acessar as variáveis
source ../../GlobalVariables.sh

# Obtém o número da última versão do histórico do script
lastVersion=$(grep -o 'v[0-9]\+\.[0-9]\+\.[0-9]\+' "../../QuickLinux.sh" | tail -n 1)

# Verifica se o número de argumentos é correto
if [ "$#" -ne 2 ]; then
    echo "Erro: Número incorreto de argumentos."
    exit 1
fi

# Obtém os valores dos argumentos
fileName="$1"
developer="$2"

# Variáveis úteis
sessionName="${programName} ${lastVersion}"
sessionDescription="Opções de referência a Sessão Internet."

# Função para instalar o AnyDesk
Install_AnyDesk() {
    ./Install_AnyDesk.sh
}

# Função para instalar o Microsoft Edge
Install_Microsoft_Edge() {
    ./Install_Microsoft_Edge.sh
}

# Função para instalar o Google Chrome
Install_Google_Chrome() {
    ./Install_Google_Chrome.sh
}

# Função para instalar o Google Earth Pro
Install_Google_Earth_Pro() {
    ./Install_Google_Earth_Pro.sh
}

# Função para instalar o  Skype para Linux
Install_Skype_for_Linux() {
    ./Install_Skype_for_Linux.sh
}

# Função para instalar o Remmina
Install_Remmina() {
    ./Install_Remmina.sh
}

# Função para instalar o Opera
Install_Opera() {
    ./Install_Opera.sh
}

# Função para instlar o FileZilla
Install_FileZilla() {
    ./Install_FileZilla.sh
}

# Função para instalar o Discord
Install_Discord() {
    ./Install_Discord.sh
}

# Função para instalar o Mozilla FireFox
Install_Mozilla_Firefox() {
    ./Install_Mozilla_Firefox.sh
}

# Função para instalar o TigerVNC Viewer
Install_TigerVNC_Viewer() {
    ./Install_TigerVNC_Viewer.sh
}

# Menu interativo usando dialog
lastChoice=0

while true; do
    choice=$(dialog --clear --backtitle "${sessionName} | ${developer}" \
            --title "${sessionName}" \
            --default-item "$lastChoice" \
            --menu "${sessionDescription}" 15 40 2 \
            0 "$(ql_label "↩️ " "Voltar...")" \
            1 "$(ql_label "🖥️ " "Instalar AnyDesk")" \
            2 "$(ql_label "🌊" "Instalar Microsoft Edge")" \
            3 "$(ql_label "🌈" "Instalar Google Chrome")" \
            4 "$(ql_label "🌍" "Instalar Google Earth Pro")" \
            5 "$(ql_label "📞" "Instalar Skype para Linux")" \
            6 "$(ql_label "🖧 " "Instalar Remmina")" \
            7 "$(ql_label "🎭" "Instalar Opera")" \
            8 "$(ql_label "📁" "Instalar FileZilla")" \
            9 "$(ql_label "💬" "Instalar Discord")" \
            10 "$(ql_label "🦊" "Instalar Mozilla Firefox")" \
            11 "$(ql_label "🖱️ " "Instalar TigerVNC Viewer")" \
            2>&1 >/dev/tty)

    # Se o usuário pressionar Cancelar, sair do loop
    if [ $? -ne 0 ]; then
        clear
        exit 0
    fi

    case $choice in
        0)
            clear
            exit 0
            ;;
        1)
            lastChoice=1
            clear
            Install_AnyDesk
            ;;
        2)
            lastChoice=2
            clear
            Install_Microsoft_Edge
            ;;
        3)
            lastChoice=3
            clear
            Install_Google_Chrome
            ;;
        4)
            lastChoice=4
            clear
            Install_Google_Earth_Pro
            ;;
        5)
            lastChoice=5
            clear
            Install_Skype_for_Linux
            ;;
        6)
            lastChoice=6
            clear
            Install_Remmina
            ;;
        7)
            lastChoice=7
            clear
            Install_Opera
            ;;
        8)
            lastChoice=8
            clear
            Install_FileZilla
            ;;
        9)
            lastChoice=9
            clear
            Install_Discord
            ;;
        10)
            lastChoice=10
            clear
            Install_Mozilla_Firefox
            ;;
        11)
            lastChoice=11
            clear
            Install_TigerVNC_Viewer
            ;;
        *)
            dialog --msgbox "Opção inválida. Tente novamente." 8 40
            ;;
    esac
done
