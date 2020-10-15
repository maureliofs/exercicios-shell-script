#!/bin/bash

###################################################################################################################
#2. Crie um script que receba um nome de processo como argumento e que constantemente irá verificar se o processo #
#está em execução. Caso não esteja, deve ser exibida uma mensagem na sessão do usuário a cada x segundos.         #
#O processo deve rodar como Daemon, ou seja, deve estar sempre em execução, verificando o processo em questão     #
#a cada x segundos.                                                                                               #
#                                                                                                                 #
#Exemplo de Execução:                                                                                             #
#                                                                                                                 #
#$ ./MonitoraProcesso.sh firefox &                                                                                #
#ATENÇÃO!!!!!!! O processo firefox NÃO está em execução!                                                          #
#ATENÇÃO!!!!!!! O processo firefox NÃO está em execução!                                                          #
#ATENÇÃO!!!!!!! O processo firefox NÃO está em execução!                                                          #
#ATENÇÃO!!!!!!! O processo firefox NÃO está em execução!                                                          #
#ATENÇÃO!!!!!!! O processo firefox NÃO está em execução!                                                          #
#ATENÇÃO!!!!!!! O processo firefox NÃO está em execução!                                                          #
###################################################################################################################

if [ $# -eq 0 ]
then
    echo "Favor informar um processo como parâmetro"
    echo "./MonitoraProcesso.sh <processo>"
    exit 1
fi

until ps aux | grep $1 | grep -v grep | grep -v $0
do
    echo "ATENÇÃO!!!!!!! O processo $1 NÃO está em execução!"
    sleep 2
done