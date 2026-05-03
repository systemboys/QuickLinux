#!/bin/bash

# System_Information.sh - Opções de ferramentas PING para redes.
#
# Autor: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
# Manutenção: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
#
# ---------------------------------------------------------------
# Este programa tem a finalidade de Opções de ferramentas PING para redes.
# ---------------------------------------------------------------
# Histórico:
# v1.0.0 2023-10-29 às 17h00, Marcos Aurélio:
#   - Versão inicial, Opções de ferramentas PING para redes.
# v1.0.1 2026-05-03 às 13h20, Marcos Aurélio:
#   - Adicionados ícones aos itens do menu.
#
# Licença: GPL.

# Incluindo o GlobalVariables.sh para acessar as variáveis
source ../../GlobalVariables.sh

# Obtém o número da última versão do histórico do script
lastVersion=$(grep -o 'v[0-9]\+\.[0-9]\+\.[0-9]\+' "../../QuickLinux.sh" | tail -n 1)

# Função para realizar o ping e mostrar o resultado em uma janela de mensagem
pingDomain() {
    # Solicita ao usuário que insira o domínio usando o dialog
    domain=$(dialog --inputbox 'Digite o domínio:' 8 40 3>&1 1>&2 2>&3)

    # Verifica se o campo de domínio está vazio
    if [ -z "$domain" ]; then
        dialog --msgbox "O domínio não pode estar vazio. Por favor, tente novamente." 8 40
        return
    fi

    # Pinga o domínio e armazena o resultado
    ping_result=$(ping -c 5 "$domain")

    # Exibe o resultado em uma janela de mensagem usando dialog
    dialog --title "Resultado do Ping para $domain" --msgbox "$ping_result" 20 100
}

# Função para realizar o ping forçando IPv4 e mostrar o resultado em uma janela de mensagem
pingDomainIPv4() {
    # Solicita ao usuário que insira o domínio usando o dialog
    domain=$(dialog --inputbox 'Digite o domínio:' 8 40 3>&1 1>&2 2>&3)

    # Verifica se o campo de domínio está vazio
    if [ -z "$domain" ]; then
        dialog --msgbox "O domínio não pode estar vazio. Por favor, tente novamente." 8 40
        return
    fi

    # Pinga o domínio e armazena o resultado
    ping_result=$(ping -4 -c 5 "$domain")

    # Exibe o resultado em uma janela de mensagem usando dialog
    dialog --title "Resultado do Ping para $domain" --msgbox "$ping_result" 20 100
}

# Função para traçar rota percorrida
Trace_Route_Traveled() {
    # Solicita ao usuário que insira o domínio usando o dialog
    domain=$(dialog --inputbox 'Digite o domínio:' 8 40 3>&1 1>&2 2>&3)

    # Verifica se o campo de domínio está vazio
    if [ -z "$domain" ]; then
        dialog --msgbox "O domínio não pode estar vazio. Por favor, tente novamente." 8 40
        return
    fi

    # Pinga o domínio e armazena o resultado
    ping_result=$(traceroute "$domain")

    # Exibe o resultado em uma janela de mensagem usando dialog
    dialog --title "Resultado do Ping de rastreio para $domain" --msgbox "$ping_result" 20 100
}

# Variáveis úteis
sessionName="${programName} ${lastVersion} 🚀🐧"

# Inicia o loop para o menu interativo usando dialog
while true; do
    # Mostra um menu para escolher entre pingar um domínio ou sair
    choice=$(dialog --clear --backtitle "${sessionName} | ${developer}" \
            --menu "Escolha uma opção:" 12 40 2 \
            0 "↩️ Voltar..." \
            1 "📡 Pingar um Domínio" \
            2 "4️⃣ Pingar um Domínio forçando IPv4" \
            3 "🛣️ Traçar rota percorrida" \
            2>&1 >/dev/tty)

    # Verifica a escolha do usuário
    case "$choice" in
        0)
            # Sai do script se o usuário escolher sair
            clear
            exit 0
            ;;
        1)
            # Chama a função para pingar um domínio
            pingDomain
            ;;
        2)
            # Chama a função para pingar um domínio forçando IPv4
            pingDomainIPv4
            ;;
        3)
            # Traçar rota percorrida
            Trace_Route_Traveled
    esac
done
