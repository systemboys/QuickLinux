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
sessionName="Sessão Internet"
sessionDescription="Opções de referência a Sessão Internet."

# Função para instalar o AnyDesk
Install_AnyDesk() {
    ./Install_AnyDesk.sh
}

# Função para Instalar o Microsoft Edge
Install_Microsoft_Edge() {
    ./Install_Microsoft_Edge.sh
}

# Função para Instalar o Google Chrome
Install_Google_Chrome() {
    ./Install_Google_Chrome.sh
}

# Menu interativo usando dialog
while true; do
    choice=$(dialog --clear --backtitle "${sessionName} | ${developer}" \
            --title "${sessionName}" \
            --menu "${sessionDescription}" 15 40 2 \
            0 "Voltar..." \
            1 "Instalar AnyDesk" \
            2 "Instalar Microsoft Edge" \
            3 "Instalar Google Chrome" \
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
            Install_AnyDesk
            ;;
        2)
            clear
            Install_Microsoft_Edge
            ;;
        3)
            clear
            Install_Google_Chrome
            ;;
        *)
            dialog --msgbox "Opção inválida. Tente novamente." 8 40
            ;;
    esac
done
