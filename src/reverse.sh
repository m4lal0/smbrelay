#!/usr/bin/env bash

LBlue='\033[0;94m'      # Ligth Blue
BRed='\033[1;31m'       # Bold Red
BBlue='\033[1;34m'      # Bold Blue
BWhite='\033[1;37m'     # Bold White
Color_Off='\033[0m'     # Text Reset

tput civis

while [ ! -f .attack ];do
    clear
    echo -e "${LBlue}[${BBlue}+${LBlue}] ${BWhite}Setting up Reverse Shell...${Color_Off}\n"
    sleep 5
done

tput cnorm

# Personalizar puerto
PORT=${1:-5040} # Puerto por defecto: 5040

# Iniciar nc con verificación
rlwrap -cAr nc -nlvp "$PORT" || {
    echo -e "${LBlue}[${BRed}✘${LBlue}] ${BWhite}Error starting nc${Color_Off}"
    exit 1
}