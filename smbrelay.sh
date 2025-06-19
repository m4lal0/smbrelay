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

export DEBIAN_FRONTEND=noninteractive
VERSION=1.0.3

trap ctrl_c INT

function ctrl_c(){
    echo -e "\n${LBlue}[${BYellow}!${LBlue}] ${BRed}Exiting...${Color_Off}"
    stopped
    exit 0
}

function helpPanel(){
    echo -e "\n${BWhite}Tool made in Bash for automating the Samba Relay Attack.${Color_Off}\n"
    echo -e "${BWhite}USAGE: \n\t ${BGreen}./smbrelay.sh${Color_Off} ${LBlue}[${BRed}-i${LBlue}] [${BRed}-u${LBlue}] [${BRed}-h${LBlue}]${Color_Off}\n"
    echo -e "${BWhite}OPTIONS:${Color_Off}"
    echo -e "\t${BRed}-i , --install \t${BPurple}Tool installation and terminal configuration.${Color_Off}"
    echo -e "\t${BRed}-u , --update \t${BPurple}Tool update.${Color_Off}"
    echo -e "\t${BRed}-h , --help \t${BPurple}Show this help message.${Color_Off}\n"
    tput cnorm; exit 0
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

function printVersion(){
    # Mostrar la versión actual de la herramienta con el banner
    banner
    echo -e "\n${White}Version: ${BWhite}$VERSION${Color_Off}\n"
    tput cnorm; exit 1
}


function checkUpdate(){
    # Obtener la versión de GitHub
    GIT_VERSION=$(curl --silent https://raw.githubusercontent.com/m4lal0/smbrelay/refs/heads/main/smbrelay.sh | grep 'VERSION=' | head -n 1 | cut -d"=" -f 2)
    
    # Verificar si se obtuvo la versión de GitHub
    if [[ -z "$GIT_VERSION" ]]; then
        echo -e "\n${LBlue}[${BRed}✘${LBlue}]${Color_Off} ${On_Red}${BWhite}Error:${Color_Off} ${BRed}Could not get the version from GitHub. Check your connection.${Color_Off}\n"
        tput cnorm; exit 1
    fi
    
    # Comparar versiones usando sort -V
    if [[ "$(printf '%s\n%s' "$VERSION" "$GIT_VERSION" | sort -V | head -n 1)" == "$GIT_VERSION" ]]; then
        echo -e "${BGreen}[✔]${Color_Off} ${BGreen}The current version ($VERSION) is the latest one.${Color_Off}\n"
        tput cnorm; exit 0
    else
        echo -e "${Yellow}[*]${Color_Off} ${IWhite}Update availables${Color_Off}"
        echo -e "${Yellow}[*]${Color_Off} ${IWhite}Upgrading the version${Color_Off} ${BWhite}$VERSION${Color_Off} ${IWhite}to the${Color_Off} ${BWhite}$GIT_VERSION${Color_Off}"
        update="1"
    fi
}

function installUpdate(){
    # Descargar e instalar la actualización desde GitHub
    echo -en "${Yellow}[*]${Color_Off} ${IWhite}Installing updates...${Color_Off}"
    # Clonación del repositorio de la herramienta
    git clone https://github.com/m4lal0/smbrelay &>/dev/null
    if [ $? -eq 0 ]; then
        chmod +x smbrelay/smbrelay.sh && mv smbrelay/src/* src &>/dev/null
        mv smbrelay/smbrelay.sh . &>/dev/null
        if [ $? -eq 0 ]; then
            echo -e "${BGreen}[ OK ]${Color_Off}"
            echo -e "\n${BGreen}[✔]${Color_Off} ${IGreen}Version updated to${Color_Off} ${BWhite}$GIT_VERSION${Color_Off}\n"
            rm -rf smbrelay &>/dev/null
            tput cnorm; exit 0
        else
            echo -e "${BRed}[ FAIL ]${Color_Off}"
            echo -e "${BRed}Error moving the file. Check permissions.${Color_Off}"
            tput cnorm; exit 1
        fi
    else
        echo -e "${BRed}[ FAIL ]${Color_Off}"
        echo -e "${BRed}Error downloading the update.${Color_Off}"
        tput cnorm; exit 1
    fi
}

function update(){
    # Gestionar el proceso de actualización de la herramienta
    banner
    echo -e "${BBlue}[+]${Color_Off} ${BWhite}Version smbrelay: $VERSION${Color_Off}"
    echo -e "${BBlue}[+]${Color_Off} ${BWhite}Checking smbrelay update${Color_Off}"
    checkUpdate
    echo -e "\t${BWhite}$VERSION ${IWhite}Installed version${Color_Off}"
    echo -e "\t${BWhite}$GIT_VERSION ${IWhite}Version in Git${Color_Off}\n"
    if [ "$update" != "1" ]; then
        tput cnorm; exit 0
    else
        echo -e "${BBlue}[+]${Color_Off} ${BWhite}Need to upgrade!${Color_Off}"
        tput cnorm
        echo -en "${BPurple}[?]${Color_Off} ${BCyan}Want to upgrade? (${BGreen}Y${BCyan}/${BRed}n${BCyan}):${Color_Off} "
        read CONDITION
        tput civis
        case "$CONDITION" in
            n|N)
                echo -e "\n${LBlue}[${BYellow}!${LBlue}] ${BRed}No update, stays on version ${BWhite}$VERSION${Color_Off}\n"
                tput cnorm; exit 0
                ;;
            *)
                installUpdate
                ;;
        esac
    fi
}

function check_dependencies() {
    local missing=()
    for program in "${dependencies[@]}"; do
        #if ! command -v "$program" > /dev/null 2>&1; then
        if ! dpkg -l | grep "$program" > /dev/null 2>&1; then
            missing+=("$program")
        fi
    done
    echo "${missing[@]}"
}

function install_dependencies() {
    local to_install=("$@")
    for program in "${to_install[@]}"; do
        echo -en "${LBlue}[${BYellow}!${LBlue}] ${BYellow}Installing ${BGreen}$program...${Color_Off}"
        if apt-get install "$program" -y > /dev/null 2>&1; then
            echo -e "${LBlue}($BGreen✔${LBlue})${Color_Off}"
        else
            echo -e "${LBlue}(${BRed}✘${LBlue})${Color_Off}"
            #log "Fallo al instalar $program"
            tput cnorm; exit 1
        fi
    done
}

function install() {
    banner
    dependencies=(terminator responder rlwrap netcat-traditional python3 nishang python3-impacket)
    echo -e "\n${LBlue}[${BBlue}+${LBlue}] ${BBlue}Checking required tools:${Color_Off}\n"
    missing_deps=($(check_dependencies))
    if [ ${#missing_deps[@]} -gt 0 ]; then
        install_dependencies "${missing_deps[@]}"
    else
        echo -e "${BGreen}[✔]${Color_Off} All tools are installed."
    fi
    if [ ! -d ~/.config/terminator ]; then
        mkdir -p ~/.config/terminator 2>/dev/null
        cp src/config ~/.config/terminator 2>/dev/null
        echo -e "${BGreen}[✔]${Color_Off} Successfully Terminator configuration."
    else
        if [ -f ~/.config/terminator/config ]; then
            cp -f src/config ~/.config/terminator 2>/dev/null
            echo -e "${BGreen}[✔]${Color_Off} Successfully replaced Terminator configuration."
        else
            cp src/config ~/.config/terminator 2>/dev/null
            echo -e "${BGreen}[✔]${Color_Off} Successfully Terminator configuration."
        fi
    fi
    #log "Instalación completada"
    echo -e "\n${LBlue}[${BYellow}!${LBlue}] ${BGreen}Run the script: ./smbrelay.sh${Color_Off}\n"
    tput cnorm; exit 0
}

function stopped(){
    for file in iface.txt .attack PS.ps1 target.txt host.txt; do
        [ -f "$file" ] && rm -f "$file" #|| echo "No se encontró $file"
    done
    pkill -f "python3.*responder" > /dev/null 2>&1 #|| echo "No Responder processes found"
    if [ -f "/usr/share/responder/Responder.conf" ]; then
        sed -i 's/SMB      = Off/SMB      = On/g' /usr/share/responder/Responder.conf
        sed -i 's/HTTP     = Off/HTTP     = On/g' /usr/share/responder/Responder.conf
    fi
    tput cnorm
}

if [ "$(id -u)" == "0" ]; then
    tput civis
    arg=""
    for arg; do
        delim=""
        case $arg in
            --help)		args="${args}-h";;
            --install)	args="${args}-i";;
            --update)   args="${args}-u";;
            --version)  args="${args}-v";;
            --*)        args="${args}*";;
            *) [[ "${arg:0:1}" == "-" ]] || delim="\""
            args="${args}${delim}${arg}${delim} ";;
        esac
    done

    eval set -- $args
    while getopts "iuvh" opt; do
        case $opt in
            i) install;;
            u) update;;
            h) helpPanel;;
            v) printVersion;;
            *) helpPanel;;
        esac
    done

    echo -e "\n${LBlue}[${BYellow}!${LBlue}] ${BGreen}Starting SMBrelay...${Color_Off}"
    sleep 2
    terminator -l smbrelay 2>/dev/null
    echo -e "\n${LBlue}[${BYellow}!${LBlue}] ${BRed}Stopping SMBrelay...${Color_Off}\n"
    stopped
else
    echo -e "\n${LBlue}[${BYellow}!${LBlue}] ${BRed}It is necessary to run the program as root!${Color_Off}\n"
fi