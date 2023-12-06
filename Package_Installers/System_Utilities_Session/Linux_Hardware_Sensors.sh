#!/bin/bash

# Linux_Hardware_Sensors.sh - Obter "Informações do processador e memória".
#
# Autor: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
# Manutenção: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
#
# ---------------------------------------------------------------
# Este programa tem a finalidade de obter informações do processador e memória.
# ---------------------------------------------------------------
# Histórico:
# v0.0.1 2023-12-06 às 17h50, Marcos Aurélio:
#   - Versão inicial, obter informações do processador e memória.
#
# Licença: GPL.

clear

# Sensores
sensors=$(sensors)

dialog --msgbox "$sensors" 8 40