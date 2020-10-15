#!/bin/bash

#######################################################################################################################################
#1. Crie um script que baseado no horário atual escreva “Bom Dia”, “Boa Tarde” ou “Boa Noite”. Considere que o começo do dia às 06:00.#
# O mesmo script deve mostrar também a hora atual no formato de 0 a 12, indicando AM ou PM.                                           #
# Exemplo de Execução:                                                                                                                #
# $ ./HoraAtual.sh                                                                                                                    #
# Boa Tarde!                                                                                                                          #
# A hora atual é: 3:39 PM                                                                                                             #
#######################################################################################################################################

if [ $(date +%H) -ge 6 ]  && [ $(date +%H) -lt 12 ]
then 
    echo "Bom Dia!"
    echo "A hora atual é: $(date +%I:%M) AM"
elif [ $(date +%H) -ge 12 ] && [ $(date +%H) -lt 18 ]
then
    echo "Boa Tarde!"
    echo "A hora atual é: $(date +%I:%M) PM"
else
    echo "Boa Noite!"
    echo "A hora atual é: $(date +%I:%M) PM"
fi