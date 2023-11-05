#!/bin/bash

# RunCommandsInTerminal.sh - Executa o script que "permite ao usuário
#                            inserir comsnos no terminal Linux".
#
# Autor: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
# Manutenção: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
#
# ---------------------------------------------------------------
# Este programa tem a finalidade de permitir que o usuário insira comandos
# no terminal Linux.
# ---------------------------------------------------------------
# Histórico:
# v0.0.1 2023-11-04 às 22h20, Marcos Aurélio:
#   - Versão inicial, permitindo que o usuário insira comandos no terminal Linux.
#
# Licença: GPL.

clear

# Solicita ao usuário que insira o domínio usando o dialog
domain=$(dialog --inputbox 'Digite o domínio:' 8 40 3>&1 1>&2 2>&3)

# Verifica se o campo de domínio está vazio
if [ -z "$domain" ]; then
    dialog --msgbox "O domínio não pode estar vazio. Por favor, tente novamente." 8 40
    return
fi

# Pinga o domínio e armazena o resultado
ping_result=$(ping -c 8 "$domain")

# Exibe o resultado em uma janela de mensagem usando dialog
dialog --title "Resultado do Ping para $domain" --msgbox "$ping_result" 20 70
