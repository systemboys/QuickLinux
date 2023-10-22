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

# Função para deletar o kernel Linux
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
    kill -SIGINT $$
}

# Função para atualizar o kernel Linux
ReloadQuickLinux() {
    (
        echo "10" ; sleep 1
        echo "30" ; sleep 1
        echo "50" ; sleep 1
        echo "70" ; sleep 1
        echo "100" ; sleep 1
    ) | dialog --title "Recarregando QuickLinux" --gauge "Aguarde, recarregando QuickLinux..." 10 70 0
    clear
    cd ../..
    ./${fileName}
    dialog --msgbox "QuickLinux recarregado!" 8 40
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
        *)
            dialog --msgbox "Opção inválida. Tente novamente." 8 40
            ;;
    esac
done