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

# Solicita ao usuário que insira um comando de terminal usando o dialog
insertedCommand=$(dialog --inputbox 'Digite seu comando numa linha só:' 8 40 3>&1 1>&2 2>&3)

# Verifica se o campo da janela Dialog está vazio
if [ -z "$insertedCommand" ]; then
    dialog --msgbox "O campo não pode estar vazio. Por favor, tente novamente." 8 40
    return
fi

# Pinga o domínio e armazena o resultado
ping_result=$("$insertedCommand")

# Exibe o resultado em uma janela de mensagem usando dialog
dialog --title "Resultado do comando $insertedCommand" --msgbox "$ping_result" 20 70
