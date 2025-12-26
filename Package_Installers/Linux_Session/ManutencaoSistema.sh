#!/bin/bash

# ManutencaoSistema.sh - Executa o script de manutenção automática do sistema.
#
# Autor: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
# Manutenção: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
#
# ---------------------------------------------------------------
# Este programa tem a finalidade de realizar manutenção automática do sistema,
# limpando cache do APT, removendo pacotes órfãos, controlando logs do systemd
# e removendo kernels antigos.
# ---------------------------------------------------------------
# Histórico:
# v1.0.0 2025-01-25 às 21h49, Marcos Aurélio:
#   - Versão inicial, manutenção automática do sistema
#
# Licença: GPL.

clear

echo "=== Manutenção automática do sistema ==="

sudo apt clean
sudo apt autoremove -y
sudo journalctl --vacuum-size=200M

sudo apt remove --purge -y $(dpkg -l 'linux-image-*' \
 | awk '/^ii/{print $2}' \
 | sort -V \
 | head -n -2)

df -h /
echo "=== Manutenção concluída ==="

dialog --msgbox "Manutenção automática do sistema concluída com sucesso!" 8 50

