#!/usr/bin/env bash

# By @m4lal0

# Regular Colors
Black='\033[0;30m'      # Black
Red='\033[0;31m'        # Red
Green='\033[0;32m'      # Green
Yellow='\033[0;33m'     # Yellow
Blue='\033[0;34m'       # Blue
Purple='\033[0;35m'     # Purple
Cyan='\033[0;36m'       # Cyan
White='\033[0;97m'      # White
Blink='\033[5m'         # Blink
Color_Off='\033[0m'     # Text Reset

# Light
LRed='\033[0;91m'       # Ligth Red
LGreen='\033[0;92m'     # Ligth Green
LYellow='\033[0;93m'    # Ligth Yellow
LBlue='\033[0;94m'      # Ligth Blue
LPurple='\033[0;95m'    # Light Purple
LCyan='\033[0;96m'      # Ligth Cyan
LWhite='\033[0;90m'     # Ligth White

# Dark
DGray='\033[2;37m'      # Dark Gray
DRed='\033[2;91m'       # Dark Red
DGreen='\033[2;92m'     # Dark Green
DYellow='\033[2;93m'    # Dark Yellow
DBlue='\033[2;94m'      # Dark Blue
DPurple='\033[2;95m'    # Dark Purple
DCyan='\033[2;96m'      # Dark Cyan
DWhite='\033[2;90m'     # Dark White

# Bold
BBlack='\033[1;30m'     # Bold Black
BRed='\033[1;31m'       # Bold Red
BGreen='\033[1;32m'     # Bold Green
BYellow='\033[1;33m'    # Bold Yellow
BBlue='\033[1;34m'      # Bold Blue
BPurple='\033[1;35m'    # Bold Purple
BCyan='\033[1;36m'      # Bold Cyan
BWhite='\033[1;37m'     # Bold White

# Italics
IBlack='\033[3;30m'     # Italic Black
IGray='\033[3;90m'      # Italic Gray
IRed='\033[3;31m'       # Italic Red
IGreen='\033[3;32m'     # Italic Green
IYellow='\033[3;33m'    # Italic Yellow
IBlue='\033[3;34m'      # Italic Blue
IPurple='\033[3;35m'    # Italic Purple
ICyan='\033[3;36m'      # Italic Cyan
IWhite='\033[3;37m'     # Italic White

# Underline
UBlack='\033[4;30m'     # Underline Black
URed='\033[4;31m'       # Underline Red
UGreen='\033[4;32m'     # Underline Green
UYellow='\033[4;33m'    # Underline Yellow
UBlue='\033[4;34m'      # Underline Blue
UPurple='\033[4;35m'    # Underline Purple
UCyan='\033[4;36m'      # Underline Cyan
UWhite='\033[4;37m'     # Underline White

# Background
On_Black='\033[40m'     # Background Black
On_Red='\033[41m'       # Background Red
On_Green='\033[42m'     # Background Green
On_Yellow='\033[43m'    # Background Yellow
On_Blue='\033[44m'      # Background Blue
On_Purple='\033[45m'    # Background Purple
On_Cyan='\033[46m'      # Background Cyan
On_White='\033[47m'     # Background White

trap ctrl_c INT

function ctrl_c(){
    echo -e "\n${LBlue}[${BYellow}!${LBlue}] ${BRed}Closes the full Terminator window.${Color_Off}\n"
    tput cnorm
}

function banner(){
    clear
    echo -e "\t${BYellow} ▄▄▄▄▄▄▄ ▄▄   ▄▄ ▄▄▄▄▄▄▄ ▄▄▄▄▄▄   ▄▄▄▄▄▄▄ ▄▄▄     ▄▄▄▄▄▄ ▄▄   ▄▄ "
    echo -e "\t█       █  █▄█  █  ▄    █   ▄  █ █       █   █   █      █  █ █  █"
    echo -e "\t█  ▄▄▄▄▄█       █ █▄█   █  █ █ █ █    ▄▄▄█   █   █  ▄   █  █▄█  █"
    echo -e "\t█ █▄▄▄▄▄█       █       █   █▄▄█▄█   █▄▄▄█   █   █ █▄█  █       █"
    echo -e "\t█▄▄▄▄▄  █       █  ▄   ██    ▄▄  █    ▄▄▄█   █▄▄▄█      █▄     ▄█"
    echo -e "\t ▄▄▄▄▄█ █ ██▄██ █ █▄█   █   █  █ █   █▄▄▄█       █  ▄   █ █   █  "
    echo -e "\t█▄▄▄▄▄▄▄█▄█   █▄█▄▄▄▄▄▄▄█▄▄▄█  █▄█▄▄▄▄▄▄▄█▄▄▄▄▄▄▄█▄█ █▄▄█ █▄▄▄█   ${Color_Off}${ICyan}By @m4lal0${Color_Off}"
    echo -e "\t                   ${On_Yellow}${BBlack}  SMB Relay Attack Script  ${Color_Off}\n"
}

# Función para obtener interfaces de red con IPs asignadas
get_interfaces() {
    local interfaces=()
    local ips=()
    while IFS= read -r line; do
        iface=$(echo "$line" | awk '{print $1}')
        ip=$(echo "$line" | awk '{print $2}')
        if [[ -n "$ip" ]]; then
            interfaces+=("$iface")
            ips+=("$ip")
        fi
    done < <(ip -4 addr show | awk '/inet / {print $NF, $2}' | sed 's_/.*__')
    echo "${interfaces[@]}"
    echo "${ips[@]}"
}

# Función principal de configuración
configuration() {
    # Obtener interfaces y sus IPs
    read -r -a IFACE <<< "$(get_interfaces | head -n 1)"
    read -r -a IPs <<< "$(get_interfaces | tail -n 1)"

    # Verificar si hay interfaces disponibles
    if [ ${#IFACE[@]} -eq 0 ]; then
        echo -e "\n${LBlue}[${BPurple}?${LBlue}] ${BWhite}No interfaces with assigned IP found.${Color_Off}"
        exit 1
    fi

    # Mostrar interfaces disponibles
    echo -e "\n\t ${ICyan}I N T E R F A C E S${Color_Off}"
    echo -e "${ICyan}----------------------------------------${Color_Off}"
    for i in "${!IFACE[@]}"; do
        echo -e " ${BYellow}$((i+1))${Color_Off}.) ${BGreen}${IFACE[$i]}${Color_Off} - ${BBlue}${IPs[$i]}${Color_Off}"
    done
    echo -e "${ICyan}----------------------------------------${Color_Off}"

    # Selección de interfaz o IP
    while true; do
        echo -ne "\n ${LBlue}[${BPurple}?${LBlue}] ${BWhite}Select an interface (1-${#IFACE[@]}) or enter an IP address:${Color_Off} "
        read input
        if [[ "$input" =~ ^[0-9]+$ ]] && [ "$input" -ge 1 ] && [ "$input" -le "${#IFACE[@]}" ]; then
            selected_iface="${IFACE[$((input-1))]}"
            selected_ip="${IPs[$((input-1))]}"
            break
        elif [[ "$input" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
            selected_ip="$input"
            selected_iface="custom"
            break
        else
            echo -e " ${LBlue}[${BRed}✘${LBlue}] ${BRed}Invalid entry. Please try again${Color_Off}"
        fi
    done

    # Confirmación de la selección
    echo -e "\n ${LBlue}[${BYellow}!${LBlue}]${Color_Off} You have select: ${BWhite}Interface: ${BYellow}${selected_iface}${Color_Off}, ${BWhite}IP: ${BYellow}${selected_ip}${Color_Off}"

    # Ingreso de la IP objetivo
    while true; do
        echo -ne "\n ${LBlue}[${BPurple}?${LBlue}] ${BWhite}Target IP:${Color_Off} "
        read target
        if [[ "$target" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
            target_ip="$target"
            break
        else
            echo -e "${LBlue}[${BRed}✘${LBlue}] ${BRed}Invalid IP. Please try again${Color_Off}"
        fi
    done

    # Guardar en archivos
    echo "$selected_ip" > host.txt
    echo "$selected_iface" > iface.txt
    echo "$target_ip" > target.txt

    # Iniciar el ataque
    touch .attack
    echo -ne "\n ${LBlue}[${BYellow}!${LBlue}] ${BYellow}Stating the attack...${Color_Off}"
    tput civis; sleep 10; read
}

banner
configuration