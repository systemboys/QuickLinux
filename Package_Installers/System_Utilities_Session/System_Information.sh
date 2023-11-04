#!/bin/bash

# System_Information.sh - Obter "Informações do processador e memória".
#
# Autor: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
# Manutenção: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
#
# ---------------------------------------------------------------
# Este programa tem a finalidade de obter informações do processador e memória.
# ---------------------------------------------------------------
# Histórico:
# v0.0.1 2023-11-04 às 17h50, Marcos Aurélio:
#   - Versão inicial, obter informações do processador e memória.
#
# Licença: GPL.

clear

# Obter informações do processador
processor_info=$(grep "model name" /proc/cpuinfo | head -n 1 | cut -d ":" -f 2 | sed 's/^[ \t]*//')

# Obter informações da memória
memory_info=$(grep "MemTotal" /proc/meminfo | cut -d ":" -f 2 | sed 's/^[ \t]*//')

# Função para formatar o tamanho em kB para MB
formatar_tamanho() {
  tamanho=$1
  tamanho_mb=$(echo "scale=2; $tamanho / 1024" | bc)
  echo "$tamanho_mb MB"
}

# Tamanho em kB a ser formatado
tamanho_kb=$memory_info

# Imprimir as informações obtidas
dialog --msgbox "Processador:
$processor_info

Memória:
$(formatar_tamanho $tamanho_kb)" 15 80

