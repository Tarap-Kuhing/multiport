#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
###########- COLOR CODE -##############
colornow=$(cat /etc/tarap/theme/color.conf)
export NC="\e[0m"
export YELLOW='\033[0;33m';
export RED="\033[0;31m"
export COLOR1="$(cat /etc/tarap/theme/$colornow | grep -w "TEXT" | cut -d: -f2|sed 's/ //g')"
export COLBG1="$(cat /etc/tarap/theme/$colornow | grep -w "BG" | cut -d: -f2|sed 's/ //g')"
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
yellow='\033[0;33m'
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
ssl2="$(cat /etc/stunnel/stunnel.conf | grep -i accept | head -n 2 | cut -d= -f2 | sed 's/ //g' | tr '\n' ' ' | awk '{print $2}')"
wsdropbear="$(cat ~/log-install.txt | grep -w "SSH(HTTP)" | cut -d: -f2|sed 's/ //g')"
wsstunnel="$(cat ~/log-install.txt | grep -w "SSL(HTTPS)" | cut -d: -f2|sed 's/ //g')"
wsovpn="$(cat ~/log-install.txt | grep -w "Websocket OpenVPN" | cut -d: -f2|sed 's/ //g')"
echo -e "\e[0;31m.-----------------------------------------.\e[0m"
echo -e "\e[0;31m|      \e[0;36mCHANGE PORT WEBSOCKET OPENSSH\e[m      \e[0;31m|\e[0m"
echo -e "\e[0;31m'-----------------------------------------'\e[0m"
echo -e " \e[1;31m>>\e[0m\e[1;33mChange Port For SSH & OVPN WS:\e[0m"
echo -e "     [1]  Change Port Websocket SSH(HTTP) $wsdropbear"
echo -e "     [2]  Change Port Websocket SSL(HTTPS) $wsstunnel"
echo -e "     [3]  Change Port Websocket OpenVPN $wsovpn"
echo -e "======================================"
echo -e "     [x]  Back To Menu Change Port"
echo -e "     [y]  Go To Main Menu"
echo -e ""
read -p "     Select From Options [1-3 or x & y] :  " prot
echo -e ""
case $prot in
1)
read -p "New Port Websocket SSH(HTTP) : " vpn
if [ -z $vpn ]; then
echo "Please Input Port"
exit 0
fi
cek=$(netstat -nutlp | grep -w $vpn)
if [[ -z $cek ]]; then
rm -f /etc/systemd/system/cdn-dropbear.service
cat > /etc/systemd/system/cdn-dropbear.service <<END
[Unit]
Description=Python WS-Dropbear
Documentation=https://Dyanvx199.me
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/bin/python -O /usr/local/bin/cdn-dropbear $vpn
Restart=on-failure

[Install]
WantedBy=multi-user.target

END
systemctl daemon-reload
systemctl enable cdn-dropbear
systemctl start cdn-dropbear
systemctl restart cdn-dropbear
sed -i "s/   - Websocket SSH(HTTP)     : $wsdropbear/   - Websocket SSH(HTTP)     : $vpn/g" /root/log-install.txt
echo -e "\e[032;1mPort $vpn modified successfully\e[0m"
else
echo -e "\e[1;31mPort Websocket SSH(HTTP) $vpn is used\e[0m"
fi
;;
2)
read -p "New Port Websocket SSL(HTTPS) : " vpn
if [ -z $vpn ]; then
echo "Please Input Port"
exit 0
fi
cek=$(netstat -nutlp | grep -w $vpn)
if [[ -z $cek ]]; then
sed -i "s/$wsstunnel/$vpn/g" /etc/stunnel/stunnel.conf
sed -i "s/   - Stunnel4                : $wsstunnel, $ssl2/   - Stunnel4                : $vpn, $ssl2/g" /root/log-install.txt
sed -i "s/   - Websocket SSL(HTTPS)    : $wsstunnel/   - Websocket SSL(HTTPS)    : $vpn/g" /root/log-install.txt
/etc/init.d/stunnel4 restart > /dev/null
echo -e "\e[032;1mPort $vpn modified successfully\e[0m"
else
echo -e "\e[1;31mPort Websocket SSL(HTTPS) $vpn is used\e[0m"
fi
;;
3)
read -p "New Port Ovpn Websocket: " vpn
if [ -z $vpn ]; then
echo "Please Input Port"
exit 0
fi
cek=$(netstat -nutlp | grep -w $vpn)
if [[ -z $cek ]]; then
rm -f /etc/systemd/system/cdn-ovpn.service
cat > /etc/systemd/system/cdn-ovpn.service <<END
[Unit]
Description=Python WS-Ovpn
Documentation=https://Dyanvx199.me
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/bin/python -O /usr/local/bin/cdn-ovpn $vpn
Restart=on-failure

[Install]
WantedBy=multi-user.target

END
systemctl daemon-reload
systemctl enable cdn-ovpn
systemctl start cdn-ovpn
systemctl restart cdn-ovpn
sed -i "s/   - OpenVPN-WS              : $wsovpn/   - OpenVPN-WS              : $vpn/g" /root/log-install.txt
echo -e "\e[032;1mPort $vpn modified successfully\e[0m"
else
echo -e "\e[1;31mPort Ovpn Websocket $vpn is used\e[0m"
fi
;;
x)
clear
change-port
;;
y)
clear
menu
;;
*)
echo "Please enter an correct number"
;;
esac
