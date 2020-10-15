#!/bin/bash

#################################################################################
#1. Crie um Script que após executado solicite dois valores como entrada. Esses #
#valores devem ser somados e o resultado exibido para o usuário.                #
#################################################################################

echo -n "Insira um numero: "
read NUMERO1
echo -n "Insira outro numero: "
read NUMERO2
echo "A soma de $NUMERO1 + $NUMERO2 é: "$[$NUMERO1 + $NUMERO2]