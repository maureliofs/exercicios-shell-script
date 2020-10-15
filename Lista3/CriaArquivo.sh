#!/bin/bash

###############################################################################################################################################
#4. Fazer um script que crie um arquivo e o preencha com um conjunto de caracteres até que um determinado tamanho em bytes seja atingido.     #
#O usuário deverá fornecer o nome do arquivo, o conjunto de caracteres que será utilizado para preenchimento do arquivo, e o tamanho final    #
#do arquivo em bytes.                                                                                                                         #
#Crie também uma lógica que mostre o andamento da criação desse arquivo, de 10 em 10%, e o tamanho atual do arquivo. Se o arquivo já existir, #
#toda a informação anterior será apagada.                                                                                                     #
#                                                                                                                                             #
#Exemplo de Execução:                                                                                                                         #
#$ ./CriaArquivo.sh                                                                                                                           #
#Informe o nome do arquivo a ser criado: arquivo_teste.out                                                                                    #
#Informe um conjunto de caracteres que será usado para preencher o arquivo: a                                                                 #
#Informe o tamanho final do arquivo (em bytes): 100000                                                                                        #
#                                                                                                                                             #
#Concluído: 10% - Tamanho do Arquivo: 10000                                                                                                   #
#Concluído:20% - Tamanho do Arquivo: 20000                                                                                                    #
#Concluído:30% - Tamanho do Arquivo: 30000                                                                                                    #
#Concluído: 40% - Tamanho do Arquivo: 40000                                                                                                   #
#Concluído: 50% - Tamanho do Arquivo: 50000                                                                                                   #
#Concluído: 60% - Tamanho do Arquivo: 60000                                                                                                   #
#Concluído: 70% - Tamanho do Arquivo: 70000                                                                                                   #
#Concluído: 80% - Tamanho do Arquivo: 80000                                                                                                   #
#Concluído: 90% - Tamanho do Arquivo: 90000                                                                                                   #
#Concluído: 100% - Tamanho do Arquivo: 100000                                                                                                 #
#                                                                                                                                             #
#Dicas:                                                                                                                                       #
#• Para saber o tamanho atual do arquivo, use o comando:                                                                                      #
#    stat --printf=%s arquivo                                                                                                                 #
#• Use a opção % do expr, que retorna o resto de uma divisão, para saber quando exibir a mensagem de porcentagem (10, 20, 30, etc)            #
###############################################################################################################################################

read -p "Informe o nome do arquivo a ser criado: " ARQUIVO
read -p "Informe um conjunto de caracteres que será usado para preencher o arquivo: " CARACTERE
read -p "Informe o tamanho final do arquivo (em bytes):" TAM_FINAL

cat /dev/null > $ARQUIVO

PORCENT_EXIBIDA=0

until [ $TAM_FINAL -le $(stat --printf=%s "$ARQUIVO") ]
do
    echo -n $CARACTERE >> $ARQUIVO
    TAM_ATUAL=$(stat --printf=%s "$ARQUIVO")

    PORCENT_ATUAL=$(expr $TAM_ATUAL \* 100 / $TAM_FINAL)

    if [ $(expr $PORCENT_ATUAL % 10) -eq 0 -a $PORCENT_EXIBIDA -ne $PORCENT_ATUAL ]
    then
        echo "Concluído: $PORCENT_ATUAL% - Tamanho do Arquivo: $TAM_ATUAL"
        PORCENT_EXIBIDA=$PORCENT_ATUAL
    fi
done