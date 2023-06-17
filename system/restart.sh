#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
###########- COLOR CODE -##############
colornow=$(cat /etc/tarap/theme/color.conf)
NC="\e[0m"
RED="\033[0;31m"
COLOR1="$(cat /etc/tarap/theme/$colornow | grep -w "TEXT" | cut -d: -f2|sed 's/ //g')"
COLBG1="$(cat /etc/tarap/theme/$colornow | grep -w "BG" | cut -d: -f2|sed 's/ //g')"
WH='\033[1;37m'
###########- END COLOR CODE -##########

BURIQ () {
    curl -sS https://raw.githubusercontent.com/kuhing/ip/main/vps > /root/tmp
    data=( `cat /root/tmp | grep -E "^### " | awk '{print $2}'` )
    for user in "${data[@]}"
    do
    exp=( `grep -E "^### $user" "/root/tmp" | awk '{print $3}'` )
    d1=(`date -d "$exp" +%s`)
    d2=(`date -d "$biji" +%s`)
    exp2=$(( (d1 - d2) / 86400 ))
    if [[ "$exp2" -le "0" ]]; then
    echo $user > /etc/.$user.ini
    else
    rm -f /etc/.$user.ini > /dev/null 2>&1
    fi
    done
    rm -f /root/tmp
}

MYIP=$(curl -sS ipv4.icanhazip.com)
Name=$(curl -sS https://raw.githubusercontent.com/kuhing/ip/main/vps | grep $MYIP | awk '{print $2}')
echo $Name > /usr/local/etc/.$Name.ini
CekOne=$(cat /usr/local/etc/.$Name.ini)

Bloman () {
if [ -f "/etc/.$Name.ini" ]; then
CekTwo=$(cat /etc/.$Name.ini)
    if [ "$CekOne" = "$CekTwo" ]; then
        res="Expired"
    fi
else
res="Permission Accepted..."
fi
}

PERMISSION () {
    MYIP=$(curl -sS ipv4.icanhazip.com)
    IZIN=$(curl -sS https://raw.githubusercontent.com/kuhing/ip/main/vps | awk '{print $4}' | grep $MYIP)
    if [ "$MYIP" = "$IZIN" ]; then
    Bloman
    else
    res="Permission Denied!"
    fi
    BURIQ
}
red='\e[1;31m'
green='\e[1;32m'
NC='\e[0m'
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
PERMISSION
if [ -f /home/needupdate ]; then
red "Your script need to update first !"
exit 0
elif [ "$res" = "Permission Accepted..." ]; then
echo -ne
else
red "Permission Denied!"
exit 0
fi
echo -e "\e[32mloading...\e[0m"
clear
echo -e ""
echo -e "${blue}══════════════════════════════════════${NC}"
echo -e "\\E[0;46;30m         RESTART VPN SERVICE          \e[0m"
echo -e "${blue}══════════════════════════════════════${NC}"
echo -e "  $green[${white}1${green}] ${green} Restart All Services$NC"
echo -e "  $green[${white}2${green}] ${green} Restart OpenSSH$NC"
echo -e "  $green[${white}3${green}] ${green} Restart Dropbear$NC"
echo -e "  $green[${white}4${green}] ${green} Restart Stunnel4$NC"
echo -e "  $green[${white}5${green}] ${green} Restart OpenVPN$NC"
echo -e "  $green[${white}6${green}] ${green} Restart Squid$NC"
echo -e "  $green[${white}7${green}] ${green} Restart Restart Nginx$NC"
echo -e "  $green[${white}8${green}] ${green} Restart Xray Core$NC"
echo -e "  $green[${white}9${green}] ${green} Restart Trojan Ws & Tcp Tls$NC"
echo -e "  $green[${white}10${green}] ${green}Restart Badvpn$NC"
echo -e "  $green[${white}11${green}] ${green}Restart OHP $NC"
echo -e "  $green[${white}12${green}] ${green}Restart WebSocket$NC"
echo -e "${blue}══════════════════════════════════════${NC}"
echo -e "\\E[0;46;30m        x)   MENU                     ${NC}"
echo -e "${blue}══════════════════════════════════════${NC}"
echo -e ""
read -p "    Select From Options [1-12 or x] :" Restart
echo -e ""
case $Restart in
                1)
                clear
                /etc/init.d/ssh restart
                /etc/init.d/dropbear restart
                /etc/init.d/stunnel4 restart
                /etc/init.d/openvpn restart
                systemctl restart --now openvpn-server@server-tcp-1194
                systemctl restart --now openvpn-server@server-udp-2200
                /etc/init.d/fail2ban restart
                /etc/init.d/cron restart
                /etc/init.d/nginx restart
                /etc/init.d/squid restart
				systemctl restart xray
				systemctl restart xray@none
				systemctl restart xray@tcp
				systemctl restart xray@vless
				systemctl restart xray@vlessnone
				systemctl restart xray@vmess
				systemctl restart xray@vmessnone
				systemctl restart xray@trojan
				systemctl restart xray@trojannone
				systemctl restart ws-http
				systemctl restart ws-https
				systemctl restart ohp
				systemctl restart ohpd
				systemctl restart ohps
			    systemctl restart cdn-dropbear
				systemctl restart cdn-ovpn
				systemctl restart cdn-ssl
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 1000
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 1000
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 1000
                echo -e ""
                echo -e "======================================"
                echo -e ""
                echo -e "          \e[0;32mALL Service Restarted\e[0m         "
                echo -e ""
                echo -e "======================================"
				echo ""
				read -n 1 -s -r -p "Press any key to back on menu"
				menu
                ;;
                2)
                clear
                /etc/init.d/ssh restart
                echo -e ""
                echo -e "======================================"
                echo -e ""
                echo -e "        \e[0;32mSSH Service Restarted\e[0m       "
                echo -e ""
                echo -e "======================================"
				echo ""
				read -n 1 -s -r -p "Press any key to back on menu"
				menu
                ;;
                3)
                clear
                /etc/init.d/dropbear restart
                echo -e ""
                echo -e "======================================"
                echo -e ""
                echo -e "       \e[0;32mDropbear Service Restarted\e[0m     "
                echo -e ""
                echo -e "======================================"
				echo ""
				read -n 1 -s -r -p "Press any key to back on menu"
				menu
                ;;
                4)
                clear
                /etc/init.d/stunnel4 restart
                echo -e ""
                echo -e "======================================"
                echo -e ""
                echo -e "        \e[0;32mStunnel4 Service Restarted\e[0m    "
                echo -e ""
                echo -e "======================================"
				echo ""
				read -n 1 -s -r -p "Press any key to back on menu"
				menu
                ;;
                5)
                clear
                /etc/init.d/openvpn restart
                systemctl restart --now openvpn-server@server-tcp-1194
                systemctl restart --now openvpn-server@server-udp-2200
                echo -e ""
                echo -e "======================================"
                echo -e ""
                echo -e "       \e[0;32mOpenVPN Service Restarted\e[0m      "
                echo -e ""
                echo -e "======================================"
				echo ""
				read -n 1 -s -r -p "Press any key to back on menu"
				menu
                ;;
                6)
                clear
                /etc/init.d/squid restart
                echo -e ""
                echo -e "======================================"
                echo -e ""
                echo -e "        \e[0;32mSquid3 Service Restarted\e[0m      "
                echo -e ""
                echo -e "======================================"
				echo ""
				read -n 1 -s -r -p "Press any key to back on menu"
				menu
                ;;
                7)
                clear
                /etc/init.d/nginx restart
                echo -e ""
                echo -e "======================================"
                echo -e ""
                echo -e "         \e[0;32mNginx Service Restarted\e[0m      "
                echo -e ""
                echo -e "======================================"
				echo ""
				read -n 1 -s -r -p "Press any key to back on menu"
				menu
                ;;
				8)
                clear
				systemctl restart xray
				systemctl restart xray@none
				systemctl restart xray@vless
				systemctl enable xray@vlessnone
				systemctl restart xray@vmess
				systemctl restart xray@vmessnone
                echo -e ""
                echo -e "======================================"
                echo -e ""
                echo -e "         \e[0;32mXray Service Restart\e[0m         "
                echo -e ""
                echo -e "======================================"
				echo ""
				read -n 1 -s -r -p "Press any key to back on menu"
				menu
                ;;
				9)
				clear
				systemctl restart xray@tcp
				systemctl restart xray@trojan
				systemctl restart xray@trojannone
                echo -e ""
                echo -e "======================================"
                echo -e ""
                echo -e "      \e[0;32mAll Trojan Service Restart\e[0m      "
                echo -e ""
                echo -e "======================================"
				echo ""
				read -n 1 -s -r -p "Press any key to back on menu"
				menu
                ;;
                10)
                clear
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7400 --max-clients 500
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7500 --max-clients 500
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7600 --max-clients 500
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7700 --max-clients 500
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7800 --max-clients 500
                screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7900 --max-clients 500
                echo -e ""
                echo -e "======================================"
                echo -e ""
                echo -e "       \e[0;32mBadvpn Service Restarted\e[0m     "
                echo -e ""
                echo -e "======================================"
				echo ""
				read -n 1 -s -r -p "Press any key to back on menu"
				menu
                ;;
				11)
				clear
                systemctl restart ohp
				systemctl restart ohpd
				systemctl restart ohps
                echo -e ""
                echo -e "======================================"
                echo -e ""
                echo -e "         \e[0;32mOHP Service Restarted\e[0m     "
                echo -e ""
                echo -e "======================================"
				echo ""
				read -n 1 -s -r -p "Press any key to back on menu"
				menu
				;;
				12)
				clear
				systemctl restart ws-http
				systemctl restart ws-https
                systemctl restart cdn-dropbear
				systemctl restart cdn-ovpn
				systemctl restart cdn-ssl
                echo -e ""
                echo -e "======================================"
                echo -e ""
                echo -e "      \e[0;32mWebSocket Service Restarted\e[0m     "
                echo -e ""
	            echo -e "======================================"
				echo ""
				read -n 1 -s -r -p "Press any key to back on menu"
				menu
                ;;
                x)
                clear
                menu
                ;;
                esac
