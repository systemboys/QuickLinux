#!/bin/bash

# System_Information.sh - Opções para assuntos relacionados ao Linux.
#
# Autor: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
# Manutenção: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
#
# ---------------------------------------------------------------
# Este programa tem a finalidade de Opções para assuntos relacionados ao Linux.
# ---------------------------------------------------------------
# Histórico:
# v0.0.1 2023-10-29 às 17h00, Marcos Aurélio:
#   - Versão inicial, Opções para assuntos relacionados ao Linux.
#
# Licença: GPL.

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
    # Loop para garantir que o usuário forneça uma senha não vazia
    while true; do
        # Captura a senha do usuário usando o dialog
        passRoot=$(dialog --title 'Redefinir senha' --passwordbox 'Por favor, informe a senha:' 0 0 3>&1 1>&2 2>&3)

        # Verifica se o usuário pressionou Cancelar
        if [ $? -ne 0 ]; then
            dialog --msgbox "Operação cancelada pelo usuário." 5 50
            exit 0
        fi

        # Verifica se a senha está vazia
        if [ -z "$passRoot" ]; then
            dialog --msgbox "Senha não pode ser vazia. Por favor, tente novamente." 6 50
        else
            # Se a senha não está vazia, tenta alterar a senha do root
            echo "root:${passRoot}" | chpasswd

            # Verifica se a alteração da senha foi bem-sucedida
            if [ $? -eq 0 ]; then
                dialog --msgbox "Senha do Usuário Root redefinida com sucesso." 6 50
                # Executa o arquivo.sh como root
                su -c "./${fileName}" root
                break
            else
                dialog --msgbox "Falha ao redefinir a senha do Usuário Root. Tente novamente." 6 50
            fi
        fi
    done
}

# Função para Opção "Executar comandos no terminal"
RunCommandsInTerminal() {
    ./RunCommandsInTerminal.sh
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
            6 "Executar comandos no terminal" \
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
        6)
            clear
            RunCommandsInTerminal
            ;;
        *)
            dialog --msgbox "Opção inválida. Tente novamente." 8 40
            ;;
    esac
done