#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

printf "${YELLOW}[INFO]${NC}: Compilando ... "
salida=$(68kasm -l es_int.s 2>&1)
if [[ $? != 0 ]]; then
  printf "${RED} ERROR ${NC}\n"
  echo -e "$salida"
  exit 1
fi
printf "${GREEN} OK ${NC}\n"

printf "${YELLOW}[INFO]${NC}: Lanzando bsvc ... \n"
bsvc practica.setup
