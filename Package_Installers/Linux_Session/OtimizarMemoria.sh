#!/bin/bash

# OtimizarMemoria.sh - Otimização de memória do Linux.
#
# Autor: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
# Manutenção: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
#
# ---------------------------------------------------------------
# Este programa tem a finalidade de otimizar a memória do Linux,
# limpando cache do sistema e reiniciando o swap.
# ---------------------------------------------------------------
# Histórico:
# v1.0.0 2025-03-19, Marcos Aurélio:
#   - Versão inicial, otimização de memória
#
# Licença: GPL.

clear

echo "=============================="
echo "   OTIMIZAÇÃO DE MEMÓRIA"
echo "=============================="
echo

echo "[1/4] Estado atual da memória:"
free -h
echo

echo "[2/4] Processos que mais consomem RAM:"
ps aux --sort=-%mem | head -15
echo

echo "[3/4] Limpando cache do sistema..."
sync
echo 3 | sudo tee /proc/sys/vm/drop_caches > /dev/null
echo "Cache limpo."
echo

echo "[4/4] Reiniciando swap..."
sudo swapoff -a && sudo swapon -a

echo
echo "Estado final da memória:"
free -h
echo
echo "Concluído."

dialog --msgbox "Otimização de memória concluída com sucesso!" 8 50
