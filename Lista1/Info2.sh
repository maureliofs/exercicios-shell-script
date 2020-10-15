#!/bin/bash

###################################################################################################
#3. Crie um script que receba um nome de usuário como parâmetro e exiba as seguintes informações: #
#• UID do usuário                                                                                 #
#• Nome Completo / Descrição do Usuário                                                           #
#• Total em Uso no /home do usuário                                                               #
#• Informações do último login do usuário                                                         #
#• [Opcional] Validar se o usuário existe ou não sem o uso do if, que ainda não foi estudado.     #
#Se não existir retorne o exit code 1, se existir retorne exit 0                                  #
###################################################################################################

echo "========================================================================="
ls /home/$1 > /dev/null 2>&1 || { echo "Usuario Inexistente"; exit 1; }
echo "Reltório do Usuário: " $1
echo ""
echo "UUID:" $(cat /etc/passwd | grep $1 | cut -d ":" -f3)
echo "Nome ou Descrição:" $(cat /etc/passwd | grep $1 | cut -d ":" -f5)
echo ""
echo "Total Usado no /home/$1: " $(du -sh /home/$1 | cut -f1)
echo ""
echo "Último Login:"
lastlog -u $1
echo "========================================================================="