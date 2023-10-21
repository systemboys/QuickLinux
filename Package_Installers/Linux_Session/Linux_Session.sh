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
sessionName="Sessão Linux"
sessionDescription="Opções de referência ao Linux."

# Função para sair do script
sair_do_script() {
    clear
    echo "Saindo do menu. Até mais!"
    exit "$1"
}

# Função para atualizar pacotes Linux
update_packages() {
    sudo apt-get update
    dialog --msgbox "Pacotes Linux atualizados!" 8 40
}

# Função para atualizar o kernel Linux
update_kernel() {
    sudo apt-get upgrade -y
    dialog --msgbox "Kernel Linux atualizado!" 8 40
}

# Função para reiniciar o Linux
restart_linux() {
    (
        echo "10" ; sleep 1
        echo "30" ; sleep 1
        echo "50" ; sleep 1
        echo "70" ; sleep 1
        echo "100" ; sleep 1
    ) | dialog --title "Reinicializando o Linux" --gauge "Aguarde, reinicializando o Linux..." 10 70 0
    sudo reboot
}

# Função para desligar o Linux
shut_down_linux() {
    (
        echo "10" ; sleep 1
        echo "30" ; sleep 1
        echo "50" ; sleep 1
        echo "70" ; sleep 1
        echo "100" ; sleep 1
    ) | dialog --title "Desligando o Linux" --gauge "Aguarde, Desligando o Linux..." 10 70 0
    sudo poweroff
}

# Função para alterar senha do usuário root
RootUserPassword() {
    dialog --passwordbox 'Digite a nova senha:' 0 0  2>/tmp/passRoot.txt
    passRoot=$( cat /tmp/passRoot.txt )
    cd ../..
    echo "$passRoot" | sudo passwd root
    echo "$passRoot" | su -c ./${fileName} root
}

# Menu interativo usando dialog
while true; do
    choice=$(dialog --clear --backtitle "${sessionName} | ${developer}" \
            --title "${sessionName}" \
            --menu "${sessionDescription}" 15 40 2 \
            0 "Voltar..." \
            1 "Atualizar pacotes Linux" \
            2 "Atualizar kernel Linux" \
            3 "Reiniciar o Linux" \
            4 "Desligar o Linux" \
            5 "Senha do usuário root" \
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
            update_packages
            ;;
        2)
            clear
            update_kernel
            ;;
        3)
            clear
            restart_linux
            ;;
        4)
            clear
            shut_down_linux
            ;;
        5)
            clear
            RootUserPassword
            ;;
        *)
            dialog --msgbox "Opção inválida. Tente novamente." 8 40
            ;;
    esac
done