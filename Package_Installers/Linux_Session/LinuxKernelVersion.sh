#!/bin/bash

# LinuxKernelVersion.sh - Executa o script que verifica a versão do Kernel Linux.
#
# Autor: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
# Manutenção: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
#
# ---------------------------------------------------------------
# Este programa tem a finalidade de verificar a versão do Kernel Linux.
# ---------------------------------------------------------------
# Histórico:
# v1.0.0 2023-11-09 às 00h45, Marcos Aurélio:
#   - Versão inicial, script que verifica a versão do kernel Linux na sessão Linux.
#
# Licença: GPL.

clear

# Verificar a versão do kernel Linux
kernel_version=$(uname -r)

dialog --msgbox "Versão do Kernel Linux é:

$kernel_version" 8 40

