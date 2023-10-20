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

# Menu interativo usando dialog
while true; do
    choice=$(dialog --clear --backtitle "${sessionName} | ${developer}" \
            --title "${sessionName}" \
            --menu "${sessionDescription}" 15 40 2 \
            1 "Atualizar pacotes Linux" \
            2 "Atualizar kernel Linux" \
            2>&1 >/dev/tty)

    # Se o usuário pressionar Cancelar, sair do loop
    if [ $? -ne 0 ]; then
        clear
        cd ../..
        ./${fileName}
    fi

    case $choice in
        1)
            clear
            update_packages
            ;;
        2)
            clear
            update_kernel
            ;;
        *)
            dialog --msgbox "Opção inválida. Tente novamente." 8 40
            ;;
    esac
done