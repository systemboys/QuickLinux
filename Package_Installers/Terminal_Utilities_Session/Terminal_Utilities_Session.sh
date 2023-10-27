#!/bin/bash

# Verifica se o número de argumentos é correto
if [ "$#" -ne 2 ]; then
    echo "Erro: Número incorreto de argumentos."
    exit 1
fi

# Obtém os valores dos argumentos
fileName="$1"
developer="$2"

# Variáveis úteis
sessionName="Utilitários de Terminal"
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
while true; do
    choice=$(dialog --clear --backtitle "${sessionName} | ${developer}" \
            --title "${sessionName}" \
            --menu "${sessionDescription}" 15 40 2 \
            0 "Voltar..." \
            1 "Instalar navegador Links2" \
            2 "Instalar navegador Lynx" \
            2>&1 >/dev/tty)

    # Se o usuário pressionar Cancelar, sair do loop
    if [ $? -ne 0 ]; then
        clear
        cd ../..
        ./${fileName}
    fi

    case $choice in
        0)
            clear
            cd ../..
            ./${fileName}
            ;;
        1)
            clear
            Install_Links2_browser
            ;;
        2)
            clear
            Install_Lynx_browser
            ;;
        *)
            dialog --msgbox "Opção inválida. Tente novamente." 8 40
            ;;
    esac
done
