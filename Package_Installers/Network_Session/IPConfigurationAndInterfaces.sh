#!/bin/bash

# IPConfigurationAndInterfaces.sh - Executa o script com opções referentes à
# configurações e interfaces de rede.
#
# URL: https://github.com/github_user/project_on_github.git
# Autor: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
# Manutenção: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
#
# ---------------------------------------------------------------
# Este programa tem a finalidade de executar o script com opções referentes à
# configurações e interfaces de rede.
# ---------------------------------------------------------------
# Histórico:
# v0.0.1 2023-11-11 às 00h30, Marcos Aurélio:
#   - Versão inicial, opções referentes à configurações e interfaces de rede.
#
# Licença: GPL.

# Função para obter as interfaces de rede do computador
GetNetworkInterfaces() {
    # Obter a lista de interfaces de rede
    interfaces=$(ifconfig -a | grep -oE '^[a-zA-Z0-9]+')

# Exibir as interfaces de rede em um bloco de código
dialog --msgbox "As interfaces de rede são:
$interfaces" 8 40
}

# Função para obter IP das interfaces de rede do computador
GetIPAddresses() {
  # Obtém o nome das interfaces de rede
  interfaces=$(ip -o link show | awk -F': ' '{print $2}')

  # Itera sobre as interfaces de rede
  for interface in $interfaces; do
    # Obtém o endereço IP da interface
    ip_address=$(ip -o -4 addr show dev $interface | awk '{split($4,a,"/"); print a[1]}')

# Exibe o endereço IP da interface
dialog --msgbox "Interface: $interface
IP Address: $ip_address" 8 40
    done
}

# Função para realizar o ping e mostrar o resultado em uma janela de mensagem
ConfigureNetworkInterface() {
    # Solicita ao usuário que insira o domínio usando o dialog
    domain=$(dialog --inputbox "Digite com base no exemplo abaixo:
eth0 192.168.0.199 255.255.255.0 192.168.0.1 192.168.0.1" 10 80 3>&1 1>&2 2>&3)

    # Verifica se o campo de domínio está vazio
    if [ -z "$domain" ]; then
        dialog --msgbox "O campo não pode estar vazio. Por favor, tente novamente." 8 40
        return
    fi

    # Pinga o domínio e armazena o resultado
    ping_result=$(ping -c 8 "$domain")

    # Exibe o resultado em uma janela de mensagem usando dialog
    dialog --title "Resultado do Ping para $domain" --msgbox "$ping_result" 20 70
}

# Inicia o loop para o menu interativo usando dialog
while true; do
    # Mostra um menu para escolher entre pingar um domínio ou sair
    choice=$(dialog --clear --backtitle "Ping Tool" \
            --menu "Escolha uma opção:" 10 40 2 \
            0 "Voltar..." \
            1 "Obter as interfaces de rede" \
            2 "Obter IP das interfaces de rede" \
            3 "Configurar interface de rede" \
            2>&1 >/dev/tty)

    # Verifica a escolha do usuário
    case "$choice" in
        0) # Sai do script se o usuário escolher sair
            clear
            exit 0
            ;;
        1) # Obter as interfaces de rede
            clear
            GetNetworkInterfaces
            ;;
        2) # Função para obter IP das interfaces de rede do computador
            clear
            GetIPAddresses
            ;;
        3) # Chama a função para pingar um domínio
            clear
            ConfigureNetworkInterface
            ;;
    esac
done

