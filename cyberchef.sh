#!/bin/bash

# Attention! Please do not change this base name to another names.

# Reset
reset='\033[0m'           # Text Reset

# Regular Colors
black='\033[0;30m'        # Black
red='\033[0;31m'          # Red
green='\033[0;32m'        # Green
yellow='\033[0;33m'       # Yellow
blue='\033[0;34m'         # Blue
purple='\033[0;35m'       # Purple
cyan='\033[0;36m'         # Cyan
white='\033[0;37m'        # White

#Prerequisites
check() {
    [[ $(command -v cyberchef) ]] && { [ $UID != 0 ] && { echo "[-] Please run as root! 'sudo cyberchef'" ; exit 1 ; } ; } || { [ $UID != 0 ] && { echo "[-] Please run as root! 'sudo bash $0'" ; exit 1 ; } ; }
    [[ $(command -v cyberchef) ]] || { chmod +x ./$0 && cp ./$0 /usr/bin/cyberchef ; }
    [[ $(command -v python3) ]] || { echo "${red}Please install python3 package manually.${reset}" ; exit 1 ; }
    [ $(command -v xdg-open) ] || { echo "${red}Please install xdg-utils package manually.${reset}"; exit 1; }
    [ -d /usr/share/cyberchef ] || mkdir /usr/share/cyberchef
    [[ $(grep "127.0.0.1    cyberchef" /etc/hosts) ]] || echo "127.0.0.1    cyberchef" >> /etc/hosts
    [ -e /usr/share/cyberchef/check.chk ] || { echo -ne "${blue}CyberChef${reset} is downloading, please be patient!.." ; wget -O "/usr/share/cyberchef/cyberchef.zip" "https://github.com/gchq/CyberChef/releases/download/v9.28.0/CyberChef_v9.28.0.zip" &> /dev/null && unzip /usr/share/cyberchef/cyberchef.zip -d /usr/share/cyberchef/ &> /dev/null && rm -f /usr/share/cyberchef/cyberchef.zip && mv /usr/share/cyberchef/CyberChef_v9.28.0.html /usr/share/cyberchef/index.html && touch /usr/share/cyberchef/check.chk && echo -e "[${green}Success,${reset} CyberChef has been downloaded. For your further questions come to our discord server and get help:\nhttps://discord.io/hack-ware]" || { echo -e "[${red}Failed to download CyberChef.${reset} If you get stuck come to our discord server for help:\nhttps://discord.io/hack-ware]" ; exit 1 ; } ; }
}
#When the user exit from the script
end() {
    kill $serverid
    exit 0
}

trap end INT

check

#Web Server and CyberChef
cd /usr/share/cyberchef
python3 -m http.server -b 127.0.0.1 80 & &> /dev/null
serverid="$!"
sudo -u ${SUDO_USER} xdg-open http://cyberchef & &> /dev/null
while :; do
    echo -e "${cyan}
  ______                _ __                              ________________  __    ______
 /_  __/___  ___  _  __(_) /_  ____  ________  __________/ ____/_  __/ __ \/ /   / ____/
  / / / __ \/ _ \| |/_/ / __/ / __ \/ ___/ _ \/ ___/ ___/ /     / / / /_/ / /   / /     
 / / / /_/ /  __/>  </ / /__ / /_/ / /  /  __(__  |__  ) /___  / / / _, _/ /___/ /___   
/_/  \____/\___/_/|_/_/\__( ) .___/_/   \___/____/____/\____/ /_/ /_/ |_/_____/\____/   
                          |/_/${reset}                                                     
"
    read
    sleep 0.2
done
