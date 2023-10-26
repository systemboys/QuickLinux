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
sessionName="Desenvolvimento"
sessionDescription="Opções de referência a Desenvolvimento."

# Função para instalar Docker
install_Docker() {
    ./install_Docker.sh
}

# Função para instalar Docker Compose
Install_Docker_Compose() {
    ./Install_Docker_Compose.sh
}

# Menu interativo usando dialog
while true; do
    choice=$(dialog --clear --backtitle "${sessionName} | ${developer}" \
            --title "${sessionName}" \
            --menu "${sessionDescription}" 15 40 2 \
            0 "Voltar..." \
            1 "Instalar Docker" \
            2 "Instalar Docker Compose" \
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
            install_Docker
            ;;
        2)
            clear
            Install_Docker_Compose
            ;;
        *)
            dialog --msgbox "Opção inválida. Tente novamente." 8 40
            ;;
    esac
done
