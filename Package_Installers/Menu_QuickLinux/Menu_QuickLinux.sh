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
sessionName="Opções do QuickLinux"
sessionDescription="Opções de referência ao QuickMenu."

# Função para atualizar pacotes Linux
UpdateQuickLinux() {
    # Your commands here
    dialog --msgbox "QuickLinux atualizados!" 8 40
}

# Função para atualizar o kernel Linux
DeleteQuickLinux() {
    # Your commands here
    dialog --msgbox "QuickLinux deletado!" 8 40
}

# Função para atualizar o kernel Linux
ReloadQuickLinux() {
    # Your commands here
    dialog --msgbox "QuickLinux recarregado!" 8 40
}

# Menu interativo usando dialog
while true; do
    choice=$(dialog --clear --backtitle "${sessionName} | ${developer}" \
            --title "${sessionName}" \
            --menu "${sessionDescription}" 15 40 2 \
            1 "Atualizar QuickLinux" \
            2 "Deletar QuickLinux" \
            3 "Recarregar QuickLinux" \
            2>&1 >/dev/tty)

    # Se o usuário pressionar Cancelar, sair do loop
    if [ $? -ne 0 ]; then
        clear
        cd ../..
        ./QuickLinux.sh
    fi

    case $choice in
        1)
            clear
            UpdateQuickLinux
            ;;
        2)
            clear
            DeleteQuickLinux
            ;;
        3)
            clear
            ReloadQuickLinux
            ;;
        *)
            dialog --msgbox "Opção inválida. Tente novamente." 8 40
            ;;
    esac
done