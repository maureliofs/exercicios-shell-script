#!/bin/bash

##################################################################################
#2. Crie um script que gere um relatório de algumas informações da máquina atual:#
#• Nome da Máquina                                                               #
#• Data e Hora Atual                                                             #
#• Desde quando a máquina está ativa                                             #
#• Versão do Kernel                                                              #
#• Quantidade de CPUs/Cores                                                      #
#• Modelo da CPU                                                                 #
#• Total de Memória RAM Disponível                                               #
#• Partições                                                                     #
##################################################################################

echo "================================================="
clear
echo "Relatorio da maquina: "$(hostname)
echo "Data/Hora: " $(date)
echo "================================================="
echo "Máquina Ativa desde: " $(uptime -s)
echo ""
echo "Versão do Kernel: " $(uname -r)
echo ""
echo "CPUs:"
echo "Quantidade de CPUs/Core:" $(cat /proc/cpuinfo | grep "model name" | wc -l) 
echo "Modelo da CPU:" $(cat /proc/cpuinfo | grep -m1 "model name" | cut -d ":" -f2)
echo ""
echo "Memória Total: " $(free -m | grep Mem | cut -c16-19) "MB"
echo ""
echo "Partições: "
df -h