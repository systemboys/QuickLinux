#!/bin/bash

# System_Information.sh - Opções para sessão relacionadas a utilitários para Linux.
#
# Autor: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
# Manutenção: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
#
# ---------------------------------------------------------------
# Este programa tem a finalidade de Opções para sessão relacionadas a utilitários para Linux.
# ---------------------------------------------------------------
# Histórico:
# v1.0.0 2023-10-29 às 17h00, Marcos Aurélio:
#   - Versão inicial, Opções para sessão relacionadas a utilitários para Linux.
# v1.0.1 2026-05-03 às 11h55, Marcos Aurélio:
#   - Ajuste no retorno da sessão para preservar a seleção no menu principal.
# v1.0.2 2026-05-03 às 13h20, Marcos Aurélio:
#   - Adicionados ícones aos itens do menu.
# v1.0.3 2026-05-03 às 17h05, Marcos Aurélio:
#   - Adicionada opção para instalar o PDFTK.
# v1.0.4 2026-05-03 às 17h15, Marcos Aurélio:
#   - Adicionada opção para instalar o ImageMagick.
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
sessionDescription="Opções de referência a Utilitários de Terminal."

# Função para instalar o navegador Links2
Install_Links2_browser() {
    ./Install_Links2_browser.sh
}

# Função para Instalar o navegador Lynx
Install_Lynx_browser() {
    ./Install_Lynx_browser.sh
}

# Função para instalar o PDFTK
Install_PDFTK() {
    ./Install_PDFTK.sh
}

# Função para instalar o ImageMagick
Install_ImageMagick() {
    ./Install_ImageMagick.sh
}

# Menu interativo usando dialog
lastChoice=0

while true; do
    choice=$(dialog --clear --backtitle "${sessionName} | ${developer}" \
            --title "${sessionName}" \
            --default-item "$lastChoice" \
            --menu "${sessionDescription}" 15 55 4 \
            0 "$(ql_label "↩️ " "Voltar...")" \
            1 "$(ql_label "🔗" "Instalar navegador Links2")" \
            2 "$(ql_label "📝" "Instalar navegador Lynx")" \
            3 "$(ql_label "📄" "Instalar PDFTK")" \
            4 "$(ql_label "🖼️ " "Instalar ImageMagick")" \
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
            Install_Links2_browser
            ;;
        2)
            lastChoice=2
            clear
            Install_Lynx_browser
            ;;
        3)
            lastChoice=3
            clear
            Install_PDFTK
            ;;
        4)
            lastChoice=4
            clear
            Install_ImageMagick
            ;;
        *)
            dialog --msgbox "Opção inválida. Tente novamente." 8 40
            ;;
    esac
done
