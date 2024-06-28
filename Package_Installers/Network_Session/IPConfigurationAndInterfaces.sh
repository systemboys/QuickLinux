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
# v1.0.0 2023-11-11 às 00h30, Marcos Aurélio:
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

  # Configurações de IP das interfaces
  ifConfig=$(ifconfig)

# Exibe o endereço IP da interface
dialog --msgbox "Interface: $interface
IP Address: $ip_address

Interfaces:
$ifConfig" 20 90
    done
}

# Função para realizar o ping e mostrar o resultado em uma janela de mensagem
ConfigureNetworkInterface() {
    # Solicita ao usuário que insira o domínio usando o dialog
    fieldWithTheData=$(dialog --inputbox "Digite com base no exemplo abaixo:
<network> <ip> <mask> <gateway> <dns>

Exemplo:
eth0 192.168.0.199 255.255.255.0 192.168.0.1 192.168.0.1" 12 80 3>&1 1>&2 2>&3)

    # Verifica se o campo de domínio está vazio
    if [ -z "$fieldWithTheData" ]; then
        dialog --msgbox "O campo não pode estar vazio. Por favor, tente novamente." 8 40
        return
    fi

    # Função que modifica as configurações da interface
    configureNetwork() {
        if [ "$#" -ne 5 ]; then
            echo "Uso: configureNetwork <network> <ip> <mask> <gateway> <dns>"
            return 1
        fi

        network="$1"
        ip="$2"
        mask="$3"
        gateway="$4"
        dns="$5"

        # Configurar o endereço IP da interface
        ifconfig "$network" "$ip" netmask "$mask"

        # Adicionar rota padrão para o gateway
        route add default gw "$gateway"

        # Configurar servidores DNS
        echo "nameserver $dns" > /etc/resolv.conf

        echo "Configuração de rede concluída:"
        ifconfig "$network"
        route -n
        cat /etc/resolv.conf
    }

    # Execução da função
    configureNetwork $fieldWithTheData

    # Obter configurações
    ifConfig=$(ifconfig)

    # Exibe mensagem de conclusão usando dialog
    dialog --title "Alterações feitas" --msgbox "Configurações autais:
$fieldWithTheData

Interfaces:
$ifConfig" 20 80
}

# Inicia o loop para o menu interativo usando dialog
while true; do
    # Mostra um menu para escolher entre pingar um domínio ou sair
    choice=$(dialog --clear --backtitle "Configuração de IP e interfaces" \
            --menu "Escolha uma opção:" 12 40 2 \
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

