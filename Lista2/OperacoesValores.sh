#!/bin/bash

####################################################################################################################
#3. Crie um script que receba do usuário 2 valores e em seguida exiba um menu para ele escolha uma                 #
#das 4 principais operações aritmétricas (soma, subtração, multiplicação e divisão). Após isso a                   #
#operação e o resultado são exibidos ao usuário.                                                                   #
#                                                                                                                  #
#Considere que:                                                                                                    #
#• O script deve validar e abortar a execução caso algum dos valores não seja informado                            #
#• No caso de multiplicação, o script deve exibir uma mensagem de erro caso um dos valores seja 0, e então abortar #
#• No caso de divisão, o script deve exibir uma mensagem de erro caso um dos valores seja 0, e então abortar       #
#• Também no caso de divisão, o script deve exibir se é uma divisão exata ou com resto.                            #
#                                                                                                                  #
#Exemplo de Execução:                                                                                              #
#$ ./OperacoesValores.sh                                                                                           #
#Informe o Valor 1: 50                                                                                             #
#Informe o Valor 2: 20                                                                                             #
#Escolha uma Operação:                                                                                             #
#1 = Soma                                                                                                          #
#2 = Subtração                                                                                                     #
#3 = Multiplicação                                                                                                 #
#4 = Divisão                                                                                                       #
#Q = Sair                                                                                                          #
#Opção: 4                                                                                                          #
#Divisão com Resto = 10                                                                                            #
#50 / 20 = 2                                                                                                       #
#Dicas:                                                                                                            #
#• O comando expr possui a opção % para obter o resto de uma divisão                                               #
####################################################################################################################

read -p "Informe o Valor 1: " NUM1
read -p "Informe o Valor 2: " NUM2

if [ "$NUM1" = "" -o "$NUM2" = "" ]
then
    exit 1
fi

echo "Escolha uma Operação:"
echo "1 = Soma"
echo "2 = Subtração"
echo "3 = Multiplicação"
echo "4 = Divisão"
echo "Q = Sair"
read -p "Opcao: " OP

case $OP in 
    1)
        echo -n "$NUM1 + $NUM2 = "
        expr $NUM1 + $NUM2
    ;;
    2) 
        echo -n "$NUM1 - $NUM2 = "
        expr $NUM1 - $NUM2
    ;;
    3) 
        if [ "$NUM1" = "0" -o "$NUM2" = "0" ]
        then
            echo "Erro! Para multiplicação os números devem ser diferentes de zero!"
        else
            echo -n "$NUM1 * $NUM2 = "
            expr $NUM1 \* $NUM2
        fi
    ;;
    4)
        if [ "$NUM1" = "0" -o "$NUM2" = "0" ]
        then
            echo "Erro! Para divisão os números devem ser diferentes de zero!"
        else
            if [ $(expr $NUM1 % $NUM2) -eq 0 ]
            then
                echo "Divisão Exata!"
                echo -n "$NUM1 / $NUM2 = "
                expr $NUM1 / $NUM2
            else
                echo -n "Divisão com resto = " 
                expr $NUM1 % $NUM2
                echo -n "$NUM1 / $NUM2 = "
                expr $NUM1 / $NUM2
            fi
        fi
    ;;
    Q)
        exit
    ;;
    *)
        echo "Opção Inválida!"
        exit 1
    ;;
esac