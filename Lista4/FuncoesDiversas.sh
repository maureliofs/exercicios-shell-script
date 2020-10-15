#!/bin/bash

################################################################################################################################
# Crie um script que receba uma opção e uma data, as opções serão as seguintes:                                                #
# * -f <DATA>: Retorna 0 para data no formato BR (DD/MM/YYYY ou DDMMYYY), 1 para formato US (MM/DD/YYYY ou MMDDYYYY), 2 quando #
# não é possível determinar (Exemplo 12/12/1990) e 3 quando o dia e mês são inválidos (Exemplo 30/30/1990)                     #
# -i <DATA>: Inverte a data de formato BR para US ou de US para BR. Sempre inclui barras.                                      #
# * -b <DATA>: Inclui as barras de data. Validar se o formato                                                                  #
# * -e <DATA>: Exibe a data em formato extenso. Exemplo de 13081918 para 13 de Agosto de 1981"                                 #
# * --help: Exibir o help do comando                                                                                           #
#                                                                                                                              #
# Cada opção deve ser implementada através de uma função.                                                                      #
#                                                                                                                              #
# Exemplos de Uso:                                                                                                             #
#                                                                                                                              #
# $ ./FuncoesDiversas.sh --help                                                                                                #
# Uso ./FuncoesDiversas.sh OPÇÃO DATA                                                                                          #
#                                                                                                                              #
# DATA nos formatos DDMMYYYY ou MMDDYYYY, com ou sem /                                                                         #
#                                                                                                                              #
# Opções:                                                                                                                      #
# -f = Retorna 0 para BR, 1 para US e 2 quando impossível determinar, 3 Inválido                                               #
# -i = Inverte formato BR para US e US para BR. Inclui as Barras                                                               #
# -b = Inclui Barras de Data. Exemplo: de 13081981 para 13/08/1981                                                             #
# -e = Exibe a data em formato extenso. Exemplo de 13081918 para 13 de Agosto de 1981                                          #
#                                                                                                                              #
# $ ./FuncoesDiversas.sh -f 08131981                                                                                           #
# 1                                                                                                                            #
#                                                                                                                              #
# $ ./FuncoesDiversas.sh -i 08131981                                                                                           #
# 13/08/1981                                                                                                                   #
#                                                                                                                              #
# $ ./FuncoesDiversas.sh -b 08131981                                                                                           #
# 08/13/1981                                                                                                                   #
#                                                                                                                              #
# $ ./FuncoesDiversas.sh -e 08131981                                                                                           #
# 13 de Agosto de 1981                                                                                                         #
#                                                                                                                              #
# $ ./FuncoesDiversas.sh -e 13081981                                                                                           #
# 13 de Agosto de 1981                                                                                                         #
#                                                                                                                              #
# $ ./FuncoesDiversas.sh -e 01121981                                                                                           #
#                                                                                                                              #
# Impossível determinar o padrão de data.                                                                                      #
# 1 - BR (DD/MM/YYYY)                                                                                                          #
# 2 - US (MM/DD/YYYY)                                                                                                          #
# Informe o formato (1 ou 2): 1                                                                                                #
#                                                                                                                              #
# 01 de Dezembro de 1981                                                                                                       #
################################################################################################################################

DATA=$(echo $2 | tr -d "/")
VALOR1=$(echo $DATA | cut -c-2)
VALOR2=$(echo $DATA | cut -c3-4)
ANO=$(echo $DATA | cut -c5-9)

determinaPadrao() {
    if [ $VALOR1 -le 12 -a $VALOR1 -eq $VALOR2 ] #DIA = MES = TANTO FAZ = BR
    then
        FORMATO=br
        return 0
    fi
    if [ $VALOR1 -le 12 -a $VALOR2 -gt 12 ] # FORMATO US
    then
        FORMATO=us
        return 1
    fi
    if [ $VALOR1 -gt 12 -a $VALOR2 -le 12 ] # FORMATO BR
    then
        FORMATO=br
        return 0
    fi
    if [ $VALOR1 -le 12 -a $VALOR2 -le 12 ] # impossivel determinar
    then
        return 2
    else
        return 3
    fi
}

inverteData () {
    determinaPadrao $1
    local FORMATO=$?
    if [ $FORMATO -ne 3 ]
    then
        echo "$VALOR2/$VALOR1/$ANO"
    else
        echo "Formato de Data Invalido"
    fi
}

incluiBarra() {
    determinaPadrao $1
    local FORMATO=$?
    if [ $FORMATO -ne 3 ]
    then
        echo "$VALOR1/$VALOR2/$ANO"
    else
        echo "Formato de Data Invalido"
    fi
}

dataExtenso() {
    determinaPadrao $1
    local RETURN_FORM=$?
    case $RETURN_FORM in
        0) 
            local DIA=$VALOR1
            local MES=$VALOR2
            ;;
        1) 
            local DIA=$VALOR2
            local MES=$VALOR1
            ;;
        2) 
            local FORMATO=0
            until [ "$FORMATO" = 1 -o "$FORMATO" = 2 ]
            do
                echo
                echo "Impossivel determinar o padrão da data."
                echo "1 - BR (DD/MM/YYYY)"
                echo "2 - US (MM/DD/YYYY)"
                read -p "Informe o formato (1 ou 2): " FORMATO
                case $FORMATO in 
                    1) 
                        local DIA=$VALOR1
                        local MES=$VALOR2
                        ;;
                    2) 
                        local DIA=$VALOR2
                        local MES=$VALOR1
                        ;;
                    *)
                        echo "Opcao invalida"
                        ;;
                esac
            done
            echo
            ;;
        3) 
            echo "Formato de Data Invalido"
            exit 3
            ;;
    esac

    case $MES in
        01) 
            local MESEXT=Janeiro
            ;;
        02) 
            local MESEXT=Fevereiro
            ;;
        03) 
            local MESEXT=Março
            ;;
        04) 
            local MESEXT=Abril
            ;;
        05) 
            local MESEXT=Maio
            ;;
        06) 
            local MESEXT=Junho
            ;;
        07) 
            local MESEXT=Julho
            ;;
        08) 
            local MESEXT=Agosto
            ;;
        09) 
            local MESEXT=Setembro
            ;;
        10) 
            local MESEXT=Outubro
            ;;
        11) 
            local MESEXT=Novembro
            ;;
        12) 
            local MESEXT=Dezembro
            ;;
        esac
    echo "$DIA de $MESEXT de $ANO"
}

case "$1" in
    "-f")
        determinaPadrao $2
        echo "$?"
    ;;
    "-i")
        inverteData $2
    ;;
    "-b")
        incluiBarra $2
    ;;
    "-e")
        dataExtenso $2
    ;;
    "--help")
        echo "Uso ./FuncoesDiversas.sh <opcao> <data>"
        echo
        echo "DATA nos formatos DDMMYYYY ou MMDDYYYY, com ou sem /"
        echo
        echo "Opções:"
        echo "-f = Retorna 0 para BR, 1 para US e 2 quando impossível determinar, 3 Inválido"
        echo "-i = Inverte formato BR para US e US para BR. Inclui as Barras"
        echo "-b = Inclui Barras de Data. Exemplo: de 13081981 para 13/08/1981"
        echo "-e = Exibe a data em formato extenso. Exemplo de 13081918 para 13 de Agosto de 1981"
    ;;
    *)
        echo "Opção Inválida! Use --help para ver as opções!"
    ;;
esac
