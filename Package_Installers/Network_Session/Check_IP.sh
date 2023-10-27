#!/bin/bash

clear

# Verifica se o curl está instalado, e instala se necessário
if ! command -v curl &> /dev/null; then
    sudo apt-get update
    sudo apt-get install curl -y
fi

# Executa o comando curl para obter o IP e armazena a saída em uma variável
ip_address=$(curl -4 http://icanhazip.com)

# Exibe o IP em uma janela de mensagem usando Dialog
dialog --msgbox "Seu endereço IP é: $ip_address" 6 40