#!/bin/bash

# FixBrokenPackages.sh - Executa o script que corrige pacotes quebrados ou dependências ausentes.
#
# Autor: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
# Manutenção: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
#
# ---------------------------------------------------------------
# Este programa tem a finalidade de corrigir pacotes quebrados ou dependências ausentes.
# ---------------------------------------------------------------
# Histórico:
# v0.0.1 2023-11-10 às 14h10, Marcos Aurélio:
#   - Versão inicial, corrigir pacotes quebrados ou dependências ausentes
#
# Licença: GPL.

clear

# Corrigir pacotes quebrados ou dependências ausentes
sudo apt --fix-broken install

dialog --msgbox "Pacotes quebrados ou dependências ausentes foram corrigidas corrigidas!" 8 40

