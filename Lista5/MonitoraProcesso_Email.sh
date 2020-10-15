#!/bin/bash

#####################################################################################################
#1. Crie uma nova versão do script criado nos exercícios de instruções de Loop, que vai monitorar a #
#execução de um processo passado como parâmetro, mas ao invés de exibir uma mensagem na tela, o     #
#script vai envir um e-mail.                                                                        #
#O processo deve rodar como Daemon, ou seja, deve estar sempre em execução, verificando o processo  #
#em questão a cada x segundos.                                                                      #
#                                                                                                   #
#Exemplo de Execução:                                                                               #
#$ ./MonitoraProcesso_Email.sh firefox &                                                            #
#####################################################################################################

USER_EMAIL=mrc
TIME=10

if [ $# -eq 0 ]
then
    echo "Favor informar um processo como parâmetro"
    echo "./MonitoraProcesso.sh <processo>"
    exit 1
else
    while true
    do
        if ps aux | grep $1 | grep -v grep | grep -v $0 > /dev/null
        then
            sleep $TIME
        else
            echo "Atencao!! O precosso $1 NAO esta em execucao!" | mail -s "[$0] Monitoração de Processo $1" $USER_EMAIL
            sleep $TIME
        fi
    done
fi

