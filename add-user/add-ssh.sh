#!/bin/bash
#wget https://github.com/${GitUser}/
GitUser="Tarap-Kuhing"

# // IZIN SCRIPT
expordateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
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
    curl -sS https://raw.githubusercontent.com/Tarap-Kuhing/Profile/main/Tarap-Kuhing > /root/tmp
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
Name=$(curl -sS https://raw.githubusercontent.com/Tarap-Kuhing/Profile/main/Tarap-Kuhing | grep $MYIP | awk '{print $2}')
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
    IZIN=$(curl -sS https://raw.githubusercontent.com/Tarap-Kuhing/Profile/main/Tarap-Kuhing | awk '{print $4}' | grep $MYIP)
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
clear

echo -e "\e[32mloading...\e[0m"
clear

# // PROVIDED
export creditt=$(cat /root/provided)

# // TEXT ON BOX COLOUR
export box=$(cat /etc/box)

# // LINE COLOUR
export line=$(cat /etc/line)

# // BACKGROUND TEXT COLOUR
export back_text=$(cat /etc/back)

clear
echo -e   "  \e[$line═══════════════════════════════════════════════════════\e[m"
echo -e   "  \e[$back_text           \e[30m[\e[$box CREATE USER SSH & OPENVPN\e[30m ]\e[1m               \e[m"
echo -e   "  \e[$line═══════════════════════════════════════════════════════\e[m"
read -p "   Username : " Login
read -p "   Password : " Pass
#read -p "   Bug SNI/Host (Example : m.facebook.com) : " sni
read -p "   Expired (days): " masaaktif

IP=$(wget -qO- icanhazip.com);
source /var/lib/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /usr/local/etc/xray/domain)
else
domain=$IP
fi

export ssl="$(cat ~/log-install.txt | grep -w "Stunnel4" | cut -d: -f2)"
export sqd="$(cat ~/log-install.txt | grep -w "Squid" | cut -d: -f2)"
export ovpn="$(netstat -nlpt | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
export ovpn2="$(netstat -nlpu | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
export ovpn3="$(cat ~/log-install.txt | grep -w "OHP OpenVPN" | cut -d: -f2|sed 's/ //g')"
export ovpn4="$(cat ~/log-install.txt | grep -w "OpenVPN SSL" | cut -d: -f2|sed 's/ //g')"
export ohpssh="$(cat ~/log-install.txt | grep -w "OHP SSH" | cut -d: -f2|sed 's/ //g')"
export ohpdrop="$(cat ~/log-install.txt | grep -w "OHP Dropbear" | cut -d: -f2|sed 's/ //g')"
export wsdropbear="$(cat ~/log-install.txt | grep -w "Websocket SSH(HTTP)" | cut -d: -f2|sed 's/ //g')"
export wsstunnel="$(cat ~/log-install.txt | grep -w "Websocket SSL(HTTPS)" | cut -d: -f2|sed 's/ //g')"
export wsovpn="$(cat ~/log-install.txt | grep -w "Websocket OpenVPN" | cut -d: -f2|sed 's/ //g')"

sleep 1
echo Ping Host
echo Check Acces...
sleep 0.5
echo Permission Accepted
clear
sleep 0.5
echo Create Acc: $Login
sleep 0.5
echo Setting Password: $Pass
sleep 0.5
clear

# // DATE
export harini=`date -d "0 days" +"%Y-%m-%d"`
useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
export exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
export exp1=`date -d "$masaaktif days" +"%Y-%m-%d"`

echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
echo -e ""
echo -e "\e[$line═══════════════════════════════════════════════════════\e[m"
echo -e "\e[$back_text         \e[30m[\e[$box Informasi Account SSH & OpenVPN\e[30m ]\e[1m           \e[m"
echo -e "\e[$line═══════════════════════════════════════════════════════\e[m"
echo -e "Username         : $Login"
echo -e "Password         : $Pass"
echo -e "Created          : $harini"
echo -e "Expired          : $exp1"
echo -e "\e[$line═══════════════════════════════════════════════════════\e[m"
echo -e "Domain           : $domain"
echo -e "IP/Host          : $MYIP"
echo -e "OpenSSH          : 22"
echo -e "Dropbear         : 143, 109"
echo -e "SSL/TLS          :$ssl"
echo -e "WS SSH(HTTP)     : $wsdropbear"
echo -e "WS SSL(HTTPS)    : $wsstunnel"
echo -e "WS OpenVPN(HTTP) : $wsovpn"
echo -e "OHP Dropbear     : $ohpdrop"
echo -e "OHP OpenSSH      : $ohpssh"
echo -e "OHP OpenVPN      : $ovpn3"
echo -e "Port Squid       :$sqd"
echo -e "Badvpn(UDPGW)    : 7100-7300"
echo -e "\e[$line═══════════════════════════════════════════════════════\e[m"
echo -e "CONFIG OPENVPN"
echo -e "--------------"
echo -e "OpenVPN TCP : $ovpn http://$MYIP:81/client-tcp-$ovpn.ovpn"
echo -e "OpenVPN UDP : $ovpn2 http://$MYIP:81/client-udp-$ovpn2.ovpn"
echo -e "OpenVPN SSL : $ovpn4 http://$MYIP:81/client-tcp-ssl.ovpn"
echo -e "OpenVPN OHP : $ovpn3 http://$MYIP:81/client-tcp-ohp1194.ovpn"
echo -e "\e[$line═══════════════════════════════════════════════════════\e[m"
echo -e "PAYLOAD WS HTTP      : GET / HTTP/1.1[crlf]Host: sshws.$domain[crlf]Upgrade: websocket[crlf][crlf]"
echo -e "\e[$line═══════════════════════════════════════════════════════\e[m"
echo -e "PAYLOAD WS HTTPS     : GET wss://$sni/ HTTP/1.1[crlf]Host: sshws.$domain[crlf]Upgrade: websocket[crlf]Connection: Keep-Alive[crlf][crlf]"
echo -e "\e[$line═══════════════════════════════════════════════════════\e[m"
echo -e "PAYLOAD WS OVPN HTTP : GET wss://$sni/ HTTP/1.1[crlf]Host: sshws.$domain[crlf]Upgrade: websocket[crlf]Connection: Keep-Alive[crlf][crlf]"
echo -e "\e[$line═══════════════════════════════════════════════════════\e[m"
echo -e "Script By $creditt"
