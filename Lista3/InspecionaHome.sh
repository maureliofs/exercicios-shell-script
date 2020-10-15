#!/bin/bash

#######################################################################################################################################
#3. Fazer um script que inspecione os diretórios /home/ de todos os usuários em busca de arquivos com as extensões .mp3, .mp4 e .jpg. #
#O script deve gerar como saída final um relatório com a quantidade de cada tipo de arquivo para cada usuário.                        #
#Exemplo de Execução:                                                                                                                 #
#$ ./InspecionaHome.sh                                                                                                                #
#                                                                                                                                     #
#Usuario: aluno1                                                                                                                      #
#Arquivos JPG: 8                                                                                                                      #
#Arquivos MP3: 0                                                                                                                      #
#Arquivos MP4: 12                                                                                                                     #
#                                                                                                                                     #
#Usuario: aluno2                                                                                                                      #
#Arquivos JPG: 0                                                                                                                      #
#Arquivos MP3: 0                                                                                                                      #
#Arquivos MP4: 0                                                                                                                      #
#                                                                                                                                     #
#Usuario: ricardo                                                                                                                     #
#Arquivos JPG: 685                                                                                                                    #
#Arquivos MP3: 0                                                                                                                      #
#Arquivos MP4: 81                                                                                                                     #
#                                                                                                                                     #
#Dicas:                                                                                                                               #
#• Você pode utilizar a seguinte sintaxe para o comando find: find /home/usuario -name '*.jpg' -o -name '*.mp4' -o -name '*.mp3'      #
#######################################################################################################################################
OLDIFS=$IFS
IFS=$'\n'

for linha in $(cat /etc/passwd)
do
    if [ $(echo $linha | cut -d ':' -f3) -ge 1000 ] && [ $(echo $linha | cut -d ':' -f3) -le 60000 ]
    then
        USUARIO=$(echo $linha | cut -d ':' -f1)
        QTDE_FOTOS=$(find /home/$USUARIO -name '*.jpg' | wc -l)
        QTDE_MUSICAS=$(find /home/$USUARIO -name '*.mp3' | wc -l)
        QTDE_VIDEOS=$(find /home/$USUARIO -name '*.mp4' | wc -l)
        echo "Usuario: $USUARIO"
        echo "Arquivos JPG: $QTDE_FOTOS"
        echo "Arquivos MP3: $QTDE_MUSICAS"
        echo "Arquivos MP4: $QTDE_VIDEOS"
        echo
    fi
done

IFS=$OLDIFS