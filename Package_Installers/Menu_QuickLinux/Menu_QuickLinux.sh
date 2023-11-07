#!/bin/bash

# System_Information.sh - Opções relacionadas ao menu Interativo QuickLinux.
#
# Autor: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
# Manutenção: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
#
# ---------------------------------------------------------------
# Este programa tem a finalidade de Opções relacionadas ao menu Interativo QuickLinux.
# ---------------------------------------------------------------
# Histórico:
# v0.0.1 2023-10-29 às 17h00, Marcos Aurélio:
#   - Versão inicial, Opções relacionadas ao menu Interativo QuickLinux.
#
# Licença: GPL.

# Incluindo o GlobalVariables.sh para acessar as variáveis
source ../../GlobalVariables.sh

# Obtém o caminho do arquivo que contém o histórico
# fileHistory="../../QuickLinux.sh"

# Obtém o número da última versão do histórico do script
latestQuicklinksVersion=$(grep -o 'v[0-9]\+\.[0-9]\+\.[0-9]\+' "../../QuickLinux.sh" | tail -n 1)

# Verifica se o número de argumentos é correto
if [ "$#" -ne 2 ]; then
    echo "Erro: Número incorreto de argumentos."
    exit 1
fi

# Obtém os valores dos argumentos
fileName="$1"
developer="$2"

# Variáveis úteis
sessionName="${programName} ${latestQuicklinksVersion} 🚀🐧"
sessionDescription="Opções de referência ao QuickMenu."

# Função para atualizar QuickLinux local pelo QuickLinux do repositório
UpdateQuickLinux() {
    (
        echo "10" ; sleep 1
        echo "30" ; sleep 1
        echo "50" ; sleep 1
        echo "70" ; sleep 1
        echo "100" ; sleep 1
    ) | dialog --title "Atualizando QuickLinux" --gauge "Aguarde, atualizando QuickLinux..." 10 70 0
    clear
    cd ../../.. && rm -rf QuickLinux && git clone https://github.com/systemboys/QuickLinux.git && cd QuickLinux && ./QuickLinux.sh
}

# Função para deletar o QuickLinux
DeleteQuickLinux() {
    (
        echo "10" ; sleep 1
        echo "30" ; sleep 1
        echo "50" ; sleep 1
        echo "70" ; sleep 1
        echo "100" ; sleep 1
    ) | dialog --title "Deletando QuickLinux" --gauge "Aguarde, deletando QuickLinux..." 10 70 0
    clear
    cd ../../..
    rm -rf QuickLinux
    clear
    dialog --msgbox 'O QuickLinux foi totalmente apagado. Adeus!' 6 40
    exit 0
    pkill -SIGINT -f "$(basename "$0")"
}

# Função para recarregar o QuickLinux
ReloadQuickLinux() {
    (
        echo "25" ; sleep 1
        echo "50" ; sleep 1
        echo "75" ; sleep 1
        echo "100" ; sleep 1
    ) | dialog --title "Recarregando QuickLinux" --gauge "Aguarde, recarregando QuickLinux..." 10 70 0
    clear
    cd ../..
    ./${fileName}
    dialog --msgbox "QuickLinux recarregado!" 8 40
}

# Função para carregar o "Sobre o QuickLinux"
AboutQuickLinux() {
    ./AboutQuickLinux.sh
}

# Menu interativo usando dialog
while true; do
    choice=$(dialog --clear --backtitle "${sessionName} | ${developer}" \
            --title "${sessionName}" \
            --menu "${sessionDescription}" 15 40 2 \
            0 "Voltar..." \
            1 "Atualizar QuickLinux" \
            2 "Deletar QuickLinux" \
            3 "Recarregar QuickLinux" \
            4 "Sobre o QuickLinux" \
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
        4)
            clear
            AboutQuickLinux
            ;;
        *)
            dialog --msgbox "Opção inválida. Tente novamente." 8 40
            ;;
    esac
done