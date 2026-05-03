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
# v1.0.0 2023-10-29 às 17h00, Marcos Aurélio:
#   - Versão inicial, Opções para assuntos relacionados ao Linux.
# v1.0.1 2023-11-09 às 01h28, Marcos Aurélio:
#   - Incrementação do "sudo apt update" junto com o "sudo apt upgrade -y" para atulizar
#     o Kernel Linux"
# v1.0.2 2026-03-19 às 23h08, Marcos Aurélio:
#   - Adicionada a opção "Otimizar memória do Linux" na sessão "Linux".
# v1.0.3 2026-04-07 às 21h24, Marcos Aurélio:
#   - Adicionada a opção "Atualizar sistema (seguro, sem kernel)" na sessão "Linux".
# v1.0.4 2026-05-03 às 11h55, Marcos Aurélio:
#   - Ajuste no retorno da sessão para preservar a seleção no menu principal.
#
# Licença: GPL.

# Incluindo o GlobalVariables.sh para acessar as variáveis
source ../../GlobalVariables.sh

lastVersion=$(grep -o 'v[0-9]\+\.[0-9]\+\.[0-9]\+' "../../QuickLinux.sh" | tail -n 1)

if [ "$#" -ne 2 ]; then
    echo "Erro: Número incorreto de argumentos."
    exit 1
fi

fileName="$1"
developer="$2"

sessionName="${programName} ${lastVersion}"
sessionDescription="Opções de referência ao Linux."

sair_do_script() {
    clear
    echo "Saindo do menu. Até mais!"
    exit "$1"
}

update_packages() {
    sudo apt-get update
    dialog --msgbox "Pacotes Linux atualizados!" 8 40
}

# 🔒 FUNÇÃO SEGURA (SEM QUEBRAR KERNEL)
update_kernel() {
    # Bloqueia kernel problemático e meta pacote
    sudo apt-mark hold linux-image-amd64 linux-headers-amd64 >/dev/null 2>&1
    sudo apt-mark hold linux-image-6.12.74+deb13+1-amd64 >/dev/null 2>&1
    sudo apt-mark hold linux-headers-6.12.74+deb13+1-amd64 >/dev/null 2>&1

    # Atualiza sistema sem mexer no kernel
    sudo apt-get update
    sudo apt-get upgrade -y

    dialog --msgbox "Sistema atualizado com segurança (kernel protegido)." 8 60
}

restart_linux() {
    (
        echo "10" ; sleep 1
        echo "30" ; sleep 1
        echo "50" ; sleep 1
        echo "70" ; sleep 1
        echo "100" ; sleep 1
    ) | dialog --title "Reinicializando o Linux" --gauge "Aguarde..." 10 70 0
    sudo reboot
}

shut_down_linux() {
    (
        echo "10" ; sleep 1
        echo "30" ; sleep 1
        echo "50" ; sleep 1
        echo "70" ; sleep 1
        echo "100" ; sleep 1
    ) | dialog --title "Desligando o Linux" --gauge "Aguarde..." 10 70 0
    sudo poweroff
}

RootUserPassword() {
    while true; do
        passRoot=$(dialog --title 'Redefinir senha' --passwordbox 'Informe a senha:' 0 0 3>&1 1>&2 2>&3)

        if [ $? -ne 0 ]; then
            dialog --msgbox "Operação cancelada." 5 50
            exit 0
        fi

        if [ -z "$passRoot" ]; then
            dialog --msgbox "Senha não pode ser vazia." 6 50
        else
            echo "root:${passRoot}" | chpasswd

            if [ $? -eq 0 ]; then
                dialog --msgbox "Senha redefinida com sucesso." 6 50
                su -c "./${fileName}" root
                break
            else
                dialog --msgbox "Erro ao redefinir senha." 6 50
            fi
        fi
    done
}

RunCommandsInTerminal() {
    ./RunCommandsInTerminal.sh
}

LinuxKernelVersion() {
    ./LinuxKernelVersion.sh
}

FixBrokenPackages() {
    ./FixBrokenPackages.sh
}

ManutencaoSistema() {
    ./ManutencaoSistema.sh
}

OtimizarMemoria() {
    ./OtimizarMemoria.sh
}

while true; do
    choice=$(dialog --clear --backtitle "${sessionName} | ${developer}" \
            --title "${sessionName}" \
            --menu "${sessionDescription}" 16 50 10 \
            0 "Voltar..." \
            1 "Atualizar pacotes Linux" \
            2 "Atualizar sistema (seguro, sem kernel)" \
            3 "Reiniciar o Linux" \
            4 "Desligar o Linux" \
            5 "Senha do usuário root" \
            6 "Executar comandos no terminal" \
            7 "Versão do kernel Linux" \
            8 "Corrigir pacotes ou dependências" \
            9 "Manutenção automática do sistema" \
            10 "Otimizar memória do Linux" \
            2>&1 >/dev/tty)

    if [ $? -ne 0 ]; then
        clear
        exit 0
    fi

    case $choice in
        0) clear; exit 0 ;;
        1) clear; update_packages ;;
        2) clear; update_kernel ;;
        3) clear; restart_linux ;;
        4) clear; shut_down_linux ;;
        5) clear; RootUserPassword ;;
        6) clear; RunCommandsInTerminal ;;
        7) clear; LinuxKernelVersion ;;
        8) clear; FixBrokenPackages ;;
        9) clear; ManutencaoSistema ;;
        10) clear; OtimizarMemoria ;;
        *) dialog --msgbox "Opção inválida." 8 40 ;;
    esac
done
