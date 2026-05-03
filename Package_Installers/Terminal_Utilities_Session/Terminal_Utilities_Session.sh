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

# Menu interativo usando dialog
lastChoice=0

while true; do
    choice=$(dialog --clear --backtitle "${sessionName} | ${developer}" \
            --title "${sessionName}" \
            --default-item "$lastChoice" \
            --menu "${sessionDescription}" 15 40 2 \
            0 "↩️ Voltar..." \
            1 "🔗 Instalar navegador Links2" \
            2 "📝 Instalar navegador Lynx" \
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
        *)
            dialog --msgbox "Opção inválida. Tente novamente." 8 40
            ;;
    esac
done
