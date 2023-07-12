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

function configuration(){
    IFACE=( $( for IFACE in $( ifconfig -s | awk '{print $1}' | grep -v "Iface" | tr '\r\n' ' ' ); do if ( ifconfig ${IFACE} | grep inet | grep -v inet6 1>/dev/null ); then echo ${IFACE}; fi; done ) )
    #IFACE=( $( for IFACE in $( \ip -o link show | awk -F': ' '{print $2}' | \tr ' ' '\n' ); do if ( \ifconfig ${IFACE} | \grep inet 1>/dev/null ); then echo ${IFACE}; fi; done ) )
    IPs=(); for (( i=0; i<${#IFACE[@]}; ++i )); do IPs+=( $( ifconfig "${IFACE[${i}]}" | grep 'inet' | grep -E '([[:digit:]]{1,2}.){4}' | sed -e 's_[:|addr|inet]__g; s_^[ \t]*__' | awk '{print $1}' ) ); done
    echo -e "\n\t ${ICyan}I N T E R F A C E S${Color_Off}"
    echo -e "${ICyan}----------------------------------------${Color_Off}"
    for iface in "${IFACE[@]}"; do
        IPs[${I}]="$( ifconfig "${iface}" | grep 'inet ' | grep -E '([[:digit:]]{1,2}.){4}' | sed -e 's_[:|addr|inet]__g; s_^[ \t]*__' | awk '{print $1}' )"
        [[ -z "${IPs[${I}]}" ]] \
        && IPs[${I}]="$( ifconfig "${iface}" | grep 'inet addr:' | cut -d':' -f2 | cut -d' ' -f1 )"
        [[ -z "${IPs[${I}]}" ]] \
        && IPs[${I}]="UNKNOWN"
        echo -e " ${BYellow}$[${I}+1]${Color_Off}.) ${BGreen}${iface}${Color_Off} - ${BBlue}${IPs[${I}]}${Color_Off}"
        I=$[${I}+1]
    done
    echo -e "${ICyan}----------------------------------------${Color_Off}"
    while [[ -z "${_IP}" ]]; do
        echo -ne "\n ${LBlue}[${BPurple}?${LBlue}] ${BWhite}Select ${BYellow}1-${I}${Color_Off}${BWhite}, or ${Color_Off}${BGreen}interface${Color_Off}"; read -p ": " INPUT
        for (( x=0; x<${I}; ++x )); do [[ "${INPUT}" == "${IFACE[${x}]}" ]] && _IP="${IPs[${x}]}" && _IFACE="${IFACE[${x}]}"; done           # Seleccionó una interfaz?
        [[ "${INPUT}" != *"."* && "${INPUT}" -ge 1 && "${INPUT}" -le "${I}" ]] && _IP="${IPs[${INPUT}-1]}" && _IFACE="${IFACE[${INPUT}-1]}"  # Seleccionó un número de opción?
        #for ip in "${IPs[@]}"; do [[ "${INPUT}" == "${ip}" ]] && _IP="${ip}"; done                                                          # Ingresó una dirección IP conocida?
        [[ "${INPUT}" =~ ^([0-9]{1,3})[.]([0-9]{1,3})[.]([0-9]{1,3})[.]([0-9]{1,3})$ ]] && _IP="${INPUT}" && _IFACE="${INPUT}"               # Ingresó una dirección IP no válida?
        echo "${_IP}" > host.txt
        echo "${_IFACE}"  > iface.txt
    done

    while [[ -z "${_TARGET}" ]]; do
        echo -ne "\n ${LBlue}[${BPurple}?${LBlue}] ${BWhite}Target IP Address:${Color_Off} "; read TARGET
        # echo -en "${BGreen} > ${Color_Off}" && read TARGET
        [[ "${TARGET}" =~ ^([0-9]{1,3})[.]([0-9]{1,3})[.]([0-9]{1,3})[.]([0-9]{1,3})$ ]] && _TARGET="${TARGET}"
        echo $TARGET > target.txt
    done

    touch .attack
    echo -ne "\n ${LBlue}[${BYellow}!${LBlue}] ${BYellow}Starting the attack...${Color_Off}"
    tput civis; sleep 10; read
}

banner
configuration