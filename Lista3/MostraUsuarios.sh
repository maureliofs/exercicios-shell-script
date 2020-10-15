#!/bin/bash

##################################################################################################################################
#1.Crie um script que mostre todos os usuários “humanos” da máquina seguidos de seu UID, Diretório Home e Nome/Descrição.        #
#Exemplo de Saída:                                                                                                               #
#USUARIO             UID             DIR HOME                NOME OU DESCRIÇÃO                                                   #
#ricardo             1000            /home/ricardo           Ricardo Prudenciato                                                 #
#aluno1              1001            /home/aluno1            Aluno de Teste 1                                                    #
#aluno2              1002            /home/aluno2            Aluno de Teste 2                                                    #
#andre               1003            /home/andre             Andre Novais                                                        #
#                                                                                                                                #
#Dicas:                                                                                                                          #
#• Baseie-se pelas informações do arquivo /etc/passwd                                                                            #
#• O arquivo /etc/login.defs mostra através dos parâmetros UID_MIN e UID_MAX os UID atribuídos aos usuários “normais” do sistema #
#• Para definir apenas a quebra de linha como separador no IFS use: IFS=$'\n'                                                    #
#• Use o a opção -e do echo para controlar o espaçamento da saída com tabs (\t)                                                  #
##################################################################################################################################

OLDIFS=$IFS
IFS=$'\n'

echo -e "USUARIO\t\t UID\t\t DIR HOME\t\t NOME OU DESCRIÇÃO"
for linha in $(cat /etc/passwd)
do
    if [ $(echo $linha | cut -d ':' -f3) -ge 1000 ] && [ $(echo $linha | cut -d ':' -f3) -le 60000 ]
    then
        UID_USER=$(echo $linha | cut -d ':' -f3)
        USUARIO=$(echo $linha | cut -d ':' -f1)
        DIR_HOME=$(echo $linha | cut -d ':' -f6)
        NOME=$(echo $linha | cut -d ':' -f5)
        echo -e "$USUARIO\t\t $UID_USER\t\t $DIR_HOME\t\t $NOME\t\t"
    fi
done

IFS=$OLDIFS