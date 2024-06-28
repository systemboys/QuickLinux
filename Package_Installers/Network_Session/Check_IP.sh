#!/bin/bash

# System_Information.sh - Verificar IP Público da conexão.
#
# Autor: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
# Manutenção: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
#
# ---------------------------------------------------------------
# Este programa tem a finalidade de Verificar IP Público da conexão.
# ---------------------------------------------------------------
# Histórico:
# v1.0.0 2023-10-29 às 17h00, Marcos Aurélio:
#   - Versão inicial, Verificar IP Público da conexão.
#
# Licença: GPL.

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