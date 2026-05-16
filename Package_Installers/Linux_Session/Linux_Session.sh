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
# v1.0.5 2026-05-03 às 13h20, Marcos Aurélio:
#   - Adicionados ícones aos itens do menu.
# v1.0.6 2026-05-03 às 13h35, Marcos Aurélio:
#   - Ajustadas opções de atualização para evitar retrabalho quando os pacotes já
#     estiverem atualizados.
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

apt_cache_is_recent() {
    local stamp_file="/var/lib/apt/periodic/update-success-stamp"
    local max_age_seconds=3600
    local now
    local stamp

    [ -f "$stamp_file" ] || return 1

    now=$(date +%s)
    stamp=$(stat -c %Y "$stamp_file" 2>/dev/null) || return 1

    [ $((now - stamp)) -lt "$max_age_seconds" ]
}

refresh_apt_cache_if_needed() {
    if apt_cache_is_recent; then
        return 0
    fi

    sudo apt-get update
}

count_upgradeable_packages() {
    apt-get -s upgrade 2>/dev/null | awk '/^Inst / {count++} END {print count + 0}'
}

update_packages() {
    if apt_cache_is_recent; then
        dialog --msgbox "A lista de pacotes já foi atualizada há menos de 1 hora.\n\nNenhuma nova consulta aos repositórios foi necessária." 8 70
        return
    fi

    if sudo apt-get update; then
        dialog --msgbox "Lista de pacotes Linux atualizada com sucesso!" 8 55
    else
        dialog --msgbox "Erro ao atualizar a lista de pacotes Linux." 8 55
    fi
}

# 🔒 FUNÇÃO SEGURA (SEM QUEBRAR KERNEL)
update_kernel() {
    clear

    # Bloqueia kernel problemático e meta pacote
    sudo apt-mark hold linux-image-amd64 linux-headers-amd64 >/dev/null 2>&1
    sudo apt-mark hold linux-image-6.12.74+deb13+1-amd64 >/dev/null 2>&1
    sudo apt-mark hold linux-headers-6.12.74+deb13+1-amd64 >/dev/null 2>&1

    # Atualiza sistema sem mexer no kernel, evitando retrabalho quando não há upgrades
    if ! refresh_apt_cache_if_needed; then
        dialog --msgbox "Erro ao atualizar a lista de pacotes. O upgrade não será executado." 8 70
        return
    fi

    upgradeablePackages=$(count_upgradeable_packages)

    if [ "$upgradeablePackages" -eq 0 ]; then
        dialog --msgbox "Sistema já está atualizado.\n\nNenhum pacote precisa de upgrade no momento." 8 60
        return
    fi

    dialog --yesno "Foram encontrados ${upgradeablePackages} pacote(s) para atualizar.\n\nExecutar upgrade seguro mantendo o kernel protegido?" 9 70
    if [ $? -ne 0 ]; then
        clear
        return
    fi

    clear

    if ! sudo apt-get upgrade -y; then
        dialog --msgbox "Erro durante o upgrade seguro do sistema." 8 60
        return
    fi

    dialog --msgbox "Sistema atualizado com segurança.\n\nKernel protegido durante o processo." 8 60
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

lastChoice=0

while true; do
    choice=$(dialog --clear --backtitle "${sessionName} | ${developer}" \
            --title "${sessionName}" \
            --default-item "$lastChoice" \
            --menu "${sessionDescription}" 16 50 10 \
            0 "$(ql_label "↩️ " "Voltar...")" \
            1 "$(ql_label "📦" "Atualizar pacotes Linux")" \
            2 "$(ql_label "🛡️ " "Atualizar sistema (seguro, sem kernel)")" \
            3 "$(ql_label "🔁" "Reiniciar o Linux")" \
            4 "$(ql_label "⏻ " "Desligar o Linux")" \
            5 "$(ql_label "🔑" "Senha do usuário root")" \
            6 "$(ql_label "⌨️ " "Executar comandos no terminal")" \
            7 "$(ql_label "🧬" "Versão do kernel Linux")" \
            8 "$(ql_label "🧩" "Corrigir pacotes ou dependências")" \
            9 "$(ql_label "🧰" "Manutenção automática do sistema")" \
            10 "$(ql_label "🧠" "Otimizar memória do Linux")" \
            2>&1 >/dev/tty)

    if [ $? -ne 0 ]; then
        clear
        exit 0
    fi

    case $choice in
        0) clear; exit 0 ;;
        1) lastChoice=1; clear; update_packages ;;
        2) lastChoice=2; clear; update_kernel ;;
        3) lastChoice=3; clear; restart_linux ;;
        4) lastChoice=4; clear; shut_down_linux ;;
        5) lastChoice=5; clear; RootUserPassword ;;
        6) lastChoice=6; clear; RunCommandsInTerminal ;;
        7) lastChoice=7; clear; LinuxKernelVersion ;;
        8) lastChoice=8; clear; FixBrokenPackages ;;
        9) lastChoice=9; clear; ManutencaoSistema ;;
        10) lastChoice=10; clear; OtimizarMemoria ;;
        *) dialog --msgbox "Opção inválida." 8 40 ;;
    esac
done
