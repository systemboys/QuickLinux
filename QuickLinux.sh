#!/bin/bash

# Verifica se o script está sendo executado como superusuário
if [ "$EUID" -ne 0 ]; then
    dialog --msgbox 'Este script precisa ser executado como superusuário.' 6 40
    clear
    exit 1
fi

# Verifica se o dialog está instalado
if ! command -v dialog &> /dev/null; then
    echo "Dialog não está instalado. Instalando..."
    sudo apt-get update
    sudo apt-get install -y dialog
fi

# Variáveis úteis
fileName=$(basename "$0")
symbol_1="\u24C7"
sessionName="QuickLinux"
sessionDescription="Selecione as opções usando (↓ ↑ → ←) e pressione \"Enter\". Pode usar os núermso ou o clique também:"
developer="${symbol_1} $(date +%Y) - GLOBAL TEC Informática | www.gti1.com.br"

# Função para executar sessão Menu QuickLinux
Menu_QuickLinux() {
    cd Package_Installers/Menu_QuickLinux
    ./Menu_QuickLinux.sh "$fileName" "$developer"
}

# Função para executar sessão Linux
Linux_Session() {
    cd Package_Installers/Linux_Session
    ./Linux_Session.sh "$fileName" "$developer"
}

# Função para executar sessão Internet
Internet_Session() {
    cd Package_Installers/Internet_Session
    ./Internet_Session.sh "$fileName" "$developer"
}

# Função para executar sessão Desenvolvimento
Development_Session() {
    cd Package_Installers/Development_Session
    ./Development_Session.sh "$fileName" "$developer"
}

# Menu interativo usando dialog
while true; do
    choice=$(dialog --clear --backtitle "${sessionName} | ${developer}" \
            --title "${sessionName}" \
            --menu "${sessionDescription}" 15 40 2 \
            1 "Menu QuickLinux" \
            2 "Linux" \
            3 "Internet" \
            4 "Desenvolvimento" \
            2>&1 >/dev/tty)

    # Se o usuário pressionar Cancelar, sair do loop
    if [ $? -ne 0 ]; then
        clear
        echo "Saindo do menu. Até mais!"
        exit 0
    fi

    case $choice in
        1) # Sessão Menu QuickLinux
            clear
            Menu_QuickLinux
            ;;
        2) # Sessão Linux
            clear
            Linux_Session
            ;;
        3) # Sessão Internet
            clear
            Internet_Session
            ;;
        4) # Sessão Desenvolvimento
            clear
            Development_Session
            ;;
        *)
            dialog --msgbox "Opção inválida. Tente novamente." 8 40
            ;;
    esac
done
