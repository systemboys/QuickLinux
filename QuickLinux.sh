#!/bin/bash

# Verifica se o dialog está instalado
if ! command -v dialog &> /dev/null; then
    echo "Dialog não está instalado. Instalando..."
    sudo apt-get update
    sudo apt-get install -y dialog
fi

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
    choice=$(dialog --clear --backtitle "QuickLinux: Desenvolvido pela GTi (www.gti1.com.br)" \
            --title "QuickLinux" \
            --menu "Selecione as opções usando (↓ ↑ → ←) e pressione \"Enter\". Pode usar os núermso ou o clique também:" 15 40 2 \
            1 "Atualizar pacotes Linux" \
            2 "Atualizar kernel Linux" \
            2>&1 >/dev/tty)

    # Se o usuário pressionar Cancelar, sair do loop
    if [ $? -ne 0 ]; then
        clear
        echo "Saindo do menu. Até mais!"
        exit 0
    fi

    case $choice in
        1) # Agualizar Pacotes Linux
            clear
            update_packages
            ;;
        2) # Atualizar Kernel Linux
            clear
            update_kernel
            ;;
        *)
            dialog --msgbox "Opção inválida. Tente novamente." 8 40
            ;;
    esac
done
