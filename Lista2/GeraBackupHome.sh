#!/bin/bash

#########################################################################################################################################
#2. Crie um script que gere um arquivo compactado de backup de todo o diretório home do usuário atual (/home/<usuario>). Considere que: #
#• O arquivo de backup será criado no diretório /home/<usuario>/Backup                                                                  #
#• O nome do arquivo de backup deve seguir o padrão backup_home_AAAAMMDDHHMM.tgz, exemplo backup_home_201708241533.tgz                  #
#• Caso o diretório /home/<usuario>/Backup não exista, o script deve criá-lo                                                            #
#• Antes de criar o backup, o script deve consultar se existe algum arquivo de backup criado na última semana. Se exisitir,             #
#o usuário deve ser consultado se deseja continuar. Se o usuário optar por não continuar, o script deve abortar com código de saída 1.  #
#• Após gerar o backup, o script deve informar o nome do arquivo gerado.                                                                #
#                                                                                                                                       #
#Exemplo de Execução:                                                                                                                   #
#$ ./GeraBackupHome.sh                                                                                                                  #
#Já foi gerado um backup do diretório /home/ricardo nos últimos 7 dias.                                                                 #
#Deseja continuar? (N/s): s                                                                                                             #
#Será criado mais um backup para a mesma semana                                                                                         #
#Criando Backup...                                                                                                                      #
#O backup de nome "backup_home_201708241547.tgz" foi criado em /home/ricardo/Backup                                                     #
#Backup Concluído!                                                                                                                      #
#########################################################################################################################################
BACKUP_DIR=$HOME/Backup
BACKUP_NAME=backup_home_$(date +%Y%m%d%H%M).tgz
DAYS7=$(find $BACKUP_DIR -ctime -7 -name backup_home\*tgz)

if [ ! -d $BACKUP_DIR ]
then
    echo "Criando Diretório $BACKUP_DIR..."
    mkdir -p $BACKUP_DIR
fi 

if [ "$DAYS7" ] # Testa se a variavel é nula
then
    echo "Já foi gerado um backup do diretório $(echo $HOME) nos últimos 7 dias."
    echo -n "Deseja continuar? (N/s): "
    read -n1 CONT #-n1 captura so 1 tecla pressionada ou o ENTER
    if [ "$CONT" = N -o "$CONT" = n -o "$CONT" = "" ]
    then
        echo ""
        echo "Backup Abortado!"
        exit 1
    elif [ "$CONT" = S -o "$CONT" = s ]
    then
    echo ""
        echo "Será criado mais um backup para a mesma semana"
    else
        echo "Opção Inválida"
        exit 2
    fi
fi
    echo "Criando Backup..."
    tar czpvf $BACKUP_DIR/$BACKUP_NAME --exclude="$BACKUP_DIR" "$HOME"/* > /dev/null 2>&1
    echo "O backup de nome \"$(echo $BACKUP_NAME)\" foi criado em $(echo $BACKUP_DIR)"
    echo "Backup Concluído!"