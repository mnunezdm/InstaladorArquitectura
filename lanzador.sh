#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' 


function quit {
	kill $(ps | grep 'wish' | awk '{print $1}')
	kill $(ps | grep 'xterm' | awk '{print $1}')
	exit 0 > /dev/null 2>&1
}

printf "${YELLOW}[INFO]${NC}: Lanzando bsvc ... \n"
bsvc practica.setup &

printf "${YELLOW}[INFO]${NC}: Compilando ... "
salida=$(68kasm -l es_int.s 2>&1)
if [[ ! $(echo -e $salida | grep "No errors detected") ]]; then
       	printf "${RED} ERROR ${NC}\n"
       	echo -e "$salida"
else
	printf "${GREEN} OK ${NC}\n"
fi

printf "${YELLOW}[INFO]${NC}: Presiona ENTER para compilar o pulsa E y despues ENTER para salir " 

while true ; do
	read -e input
	if [[ "$input" == "e" ]] ; then
		quit;	
	fi
	printf "${YELLOW}[INFO]${NC}: Compilando ... "
	salida=$(68kasm -l es_int.s 2>&1)
	if [[ ! $(echo -e $salida | grep "No errors detected") ]]; then
        	printf "${RED} ERROR ${NC}"
        	echo -e "$salida"
	else
		printf "${GREEN} OK ${NC}"
    	fi
done

