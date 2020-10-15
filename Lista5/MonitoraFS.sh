#!/bin/bash

##############################################################################################
#2. Criar um script que sendo executado pela crontab do sistema, verifica a porcentagem de   #
#utilização de todas as partições (/dev/*) e envia um e-mail de alerta para cada partição    #
#que estiver acima de um limite estabelecido dentro do script.                               #
#O programa também deve gerar um log quando o uso estiver acima do normal.                   #
#                                                                                            #
#*Para gerar o log, considere que você não tem acesso ou permissão para                      #
#configurar o rsyslog, dessa forma use o método de redirecionamento de saídas                #
#diretamente para o arquivo de log desejado                                                  #
##############################################################################################

EMAIL=mrc
LIMITE=15
ARQ_TEMP=/tmp/monitora-praticao.tmp
LOG=/var/log/scripts/$(basename $0).log

for loop  in $(df -h | grep sda | tr -s " " | tr -s ' ' ':')
do
    USO=$(echo $loop | cut -d ":" -f5 | tr -d "%")
    if [ $USO -ge $LIMITE ]
    then
        PARTICAO=$(echo $loop | cut -d ":" -f6)

        # Gera e envia email
        echo "Atencao! A particao $PARTICAO esta com uso acima do limite configurado" >> $ARQ_TEMP
        echo >> $ARQ_TEMP
        echo "Limite = $LIMITE%" >> $ARQ_TEMP
        echo >> $ARQ_TEMP
        df -h $PARTICAO >> $ARQ_TEMP

        mail -s "[$0] - Verificar Particao $PARTICAO" $EMAIL < $ARQ_TEMP

        #Gera Log
        echo "$(date "+%d/%m/%Y %H:%M") - Particao $PARTICAO - Uso $USO%" >> $LOG
        rm -f $ARQ_TEMP
    fi
done
