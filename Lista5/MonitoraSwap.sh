#!/bin/bash

#############################################################################################
#3. Escreva um script que vai monitorar o uso de swap do sistema, obtido através do comando #
#“free -m” ou do arquivo “/proc/swaps.”                                                     #
#O script deve ter duas configurações de limite diferentes, um para o registro de log, e um #
#para o envio de e-mail de alerta.                                                          #
#Se a porcentagem de uso da Swap ultrapassar X%, por exemplo 50%, deve ser incluído um      #
#registro no log do processo.                                                               #
#Se a porcentagem de uso da Swap ultrapassar Y%, por exemplo 80%, além do registro no log,  #
#deve ser enviado um e-mail ao administrador do sistema.                                    #
#* Nesse caso, gere o log através do rsyslog e do comando logger                            #
#############################################################################################

# Cria um novo arquivo dentro de /etc/rsyslog.d/ com o conteudo:
# local0:*          /var/log/scripts/MonitoraSwap.log
# systemctl restart rsyslog

EMAIL=mrc
LIMITE_LOG=50
LIMITE_EMAIL=80
ARQ_TEMP=/tmp/monitora-swap.tmp

USO=$(free -m | grep SWAP | tr -s " " | cut -d " " -f3)
TOTAL=$(free -m | grep SWAP | tr -s " " | cut -d " " -f2)
#PERC=$(expr $USO / $TOTAL \* 100)
PERC=70

if [ $PERC -ge $LIMITE_LOG ]
then
    logger -p local0.warn -t [MonitoraSwap] "Uso de Swap = $PERC%"
    if [ $PERC -ge $LIMITE_EMAIL ]
    then
        echo "Atencao! O uso do swap esta acima do limite.\n" >> $ARQ_TEMP
        echo "Limite = $LIMITE_EMAIL%" >> $ARQ_TEMP
        echo -e "Valor Atual = $PERC%\n" >> $ARQ_TEMP
        free -m >> $ARQ_TEMP
        mail -s "[basename $0] - Uso de swap acima de $LIMITE_EMAIL%" $EMAIL < $ARQ_TEMP
    fi
fi

rm -f $ARQ_TEMP