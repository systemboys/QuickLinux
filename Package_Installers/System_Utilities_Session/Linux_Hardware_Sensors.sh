#!/bin/bash

# Linux_Hardware_Sensors.sh - Obter "Informações de Hardware do computador".
#
# Autor: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
# Manutenção: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
#
# ---------------------------------------------------------------
# Este programa tem a finalidade de obter informações de Hardware do computador.
# ---------------------------------------------------------------
# Histórico:
# v0.0.1 2023-12-06 às 17h50, Marcos Aurélio:
#   - Versão inicial, obter informações de Hardware do computador.
#
# Licença: GPL.

clear

# Sensores
sensors=$(sensors)

dialog --msgbox "$sensors" 20 95