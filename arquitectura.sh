#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

if [[ $(whoami) != "root" ]] ; then
	printf "${RED}[FATAL]: ejecuta como administrador 'sudo $0' ${NC}\n" >&2
	exit 1
fi

mkdir ArquitecturaTemporal >/dev/null 2>&1
cd ArquitecturaTemporal

printf "${YELLOW}[INFO]${NC}: descargando archivos"
wget http://www.datsi.fi.upm.es/docencia/Arquitectura_09/Proyecto_E_S/bsvc-2.1+_Estatica.tar.gz >/dev/null 2>&1
if [[ $? != 0 ]]; then
	printf "${RED} ERROR ${NC}\n"
	printf "${RED}[FATAL]: ¿tienes conexion a internet? ${NC}\n" >&2
	exit 1
fi
printf "${GREEN} OK ${NC}\n"

printf "${YELLOW}[INFO]${NC}: instalando y configurando bsvc"
tar -xvzf bsvc-2.1+_Estatica.tar.gz >/dev/null 2>&1
mv usr/local/* /usr/local/ 2>/dev/null
cd ..
rm -fr ArquitecturaTemporal
mv /usr/local/bsvc/bin/UI/bsvc.ad /usr/local/bsvc/bin/UI/bsvc.ad.backup
touch /usr/local/bsvc/bin/UI/bsvc.ad
printf "${GREEN} OK ${NC}\n"

printf "${YELLOW}[INFO]${NC}: configurando la variable PATH"
echo $PATH | grep "bsvc/bin" || echo PATH='$PATH':/usr/local/bsvc/bin >> ~/.bashrc && export PATH=$PATH:/usr/local/bsvc/bin
printf "${GREEN} OK ${NC}\n"

printf "${YELLOW}[INFO]${NC}: instalando programas adicionales"
apt-get install -qq -y git xterm tclsh wish
printf "${GREEN} OK ${NC}\n"

printf "\nA partir de ahora usa el comando './lanzador.sh' para compilar y ejecutar"
