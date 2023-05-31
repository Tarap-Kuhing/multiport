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
clear

echo -e "\e[32mloading...\e[0m"
clear
# LINE COLOUR
line=$(cat /etc/line)
# TEXT COLOUR BELOW
below=$(cat /etc/below)
# BACKGROUND TEXT COLOUR
back_text=$(cat /etc/back)
# NUMBER COLOUR
number=$(cat /etc/number)
# TEXT ON BOX COLOUR
box=$(cat /etc/box)
clear
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- ifconfig.me/ip);
clear
echo -e ""
echo -e "   \e[$line════════════════════════════════════════\e[m"
echo -e "   \e[$back_text             \e[30m═[\e[$box SYSTEM MENU\e[30m ]═          \e[m"
echo -e "   \e[$line════════════════════════════════════════\e[m"
echo -e "   \e[$number (•1)\e[m \e[$below Add New Subdomain\e[m"
echo -e "   \e[$number (•2)\e[m \e[$below Renew Cert Xray Core\e[m"
echo -e "   \e[$number (•3)\e[m \e[$below Setup DNS NETFLIX\e[m"
echo -e "   \e[$number (•4)\e[m \e[$below Check DNS NETFLIX\e[m"
echo -e "   \e[$number (•5)\e[m \e[$below Panel Domain\e[m"
echo -e "   \e[$number (•6)\e[m \e[$below Backup Vps\e[m"
echo -e "   \e[$number (•7)\e[m \e[$below Autobackup Vps\e[m"
echo -e "   \e[$number (•8)\e[m \e[$below Restore Vps\e[m"
echo -e "   \e[$number (•9)\e[m \e[$below Install Webmin\e[m"
echo -e "   \e[$number (10)\e[m \e[$below Setup Speed VPS\e[m"
echo -e "   \e[$number (11)\e[m \e[$below Restart VPN\e[m"
echo -e "   \e[$number (12)\e[m \e[$below Speedtest VPS\e[m"
echo -e "   \e[$number (13)\e[m \e[$below Info All Port\e[m"
echo -e "   \e[$number (14)\e[m \e[$below Install BBR\e[m"
echo -e "   \e[$number (15)\e[m \e[$below ON/OF Auto Reboot\e[m"
echo -e "   \e[$number (16)\e[m \e[$below Change Password VPS\e[m"
echo -e "   \e[$number (17)\e[m \e[$below Backup\e[m"
echo -e "   \e[$number (18)\e[m \e[$below Update Script\e[m"
echo -e "   \e[$line════════════════════════════════════════\e[m"
echo -e "   \e[$back_text \e[$box x)   MENU                             \e[m"
echo -e "   \e[$line════════════════════════════════════════\e[m"
echo -e "\e[$line"
read -p "    Please Input Number  [1-17 or x] :  "  sys
echo -e ""
case $sys in
1)
add-host
;;
2)
cert
;;
3)
dns
;;
4)
nf
;;
5)
panel-domain
;;
6)
backup
;;
7)
autobackup
;;
8)
restore
;;
9)
wbmn
;;
10)
limit-speed
;;
11)
restart
;;
12)
speedtest
;;
13)
about
;;
14)
bbr
;;
15)
autoreboot
;;
16)
passwd
;;
17)
tes
;;
18)
update
;;
x)
menu
;;
*)
echo "Please enter an correct number"
sleep 1
system
;;
esac
