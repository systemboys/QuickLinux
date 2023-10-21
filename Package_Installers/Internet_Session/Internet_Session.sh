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

# Menu interativo usando dialog
while true; do
    choice=$(dialog --clear --backtitle "${sessionName} | ${developer}" \
            --title "${sessionName}" \
            --menu "${sessionDescription}" 15 40 2 \
            0 "Voltar..." \
            1 "Instalar AnyDesk" \
            2 "Instalar Microsoft Edge" \
            3 "Instalar Google Chrome" \
            4 "Instalar Google Earth Pro" \
            5 "Instalar Skype para Linux" \
            6 "Instalar Remmina" \
            7 "Instalar Opera" \
            8 "Instalar FileZilla" \
            9 "Instalar Discord" \
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
        4)
            clear
            Install_Google_Earth_Pro
            ;;
        5)
            clear
            Install_Skype_for_Linux
            ;;
        6)
            clear
            Install_Remmina
            ;;
        7)
            clear
            Install_Opera
            ;;
        8)
            clear
            Install_FileZilla
            ;;
        9)
            clear
            Install_Discord
            ;;
        *)
            dialog --msgbox "Opção inválida. Tente novamente." 8 40
            ;;
    esac
done
