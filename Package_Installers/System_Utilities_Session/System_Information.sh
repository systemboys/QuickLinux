#!/bin/bash

# System_Information.sh - Obter informações do processador, memória e placa-mãe.
#
# Autor: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
# Manutenção: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
#
# ---------------------------------------------------------------
# Este programa tem a finalidade de obter informações do processador, memória e
# placa-mãe.
# ---------------------------------------------------------------
# Histórico:
# v1.0.0 2023-11-04 às 17h50, Marcos Aurélio:
#   - Versão inicial, obter informações do processador e memória.
# v1.0.1 2026-05-03 às 16h50, Marcos Aurélio:
#   - Adicionadas informações da placa-mãe obtidas pelo DMI.
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

read_dmi_value() {
  field="$1"
  file="/sys/devices/virtual/dmi/id/${field}"

  [ -r "$file" ] || {
    echo "Não disponível"
    return
  }

  value=$(cat "$file" 2>/dev/null | sed 's/^[ \t]*//;s/[ \t]*$//')

  case "$value" in
    ""|"Default string"|"To be filled by O.E.M."|"To Be Filled By O.E.M."|"Not Applicable"|"None"|"Unknown")
      echo "Não disponível"
      ;;
    *)
      echo "$value"
      ;;
  esac
}

# Tamanho em kB a ser formatado
tamanho_kb=$memory_info

motherboard_vendor=$(read_dmi_value "board_vendor")
motherboard_name=$(read_dmi_value "board_name")
motherboard_version=$(read_dmi_value "board_version")
motherboard_serial=$(read_dmi_value "board_serial")

# Imprimir as informações obtidas
dialog --msgbox "Processador:
$processor_info

Memória:
$(formatar_tamanho $tamanho_kb)

Placa-mãe:
Fabricante: $motherboard_vendor
Modelo: $motherboard_name
Versão: $motherboard_version
Serial: $motherboard_serial" 18 80
