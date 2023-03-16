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
    curl -sS https://raw.githubusercontent.com/jambanbkn/tarap/main/ipvps > /root/tmp
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
Name=$(curl -sS https://raw.githubusercontent.com/jambanbkn/tarap/main/ipvps | grep $MYIP | awk '{print $2}')
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
    IZIN=$(curl -sS https://raw.githubusercontent.com/jambanbkn/tarap/main/ipvps | awk '{print $4}' | grep $MYIP)
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
echo ""
echo -e "   .-----------------------------------."
echo -e "   |   \e[1;32mPlease select acme for domain\e[0m   |"
echo -e "   '-----------------------------------'"
echo -e "     \e[1;32m1)\e[0m ZeroSSL.com"
echo -e "     \e[1;32m2)\e[0m BuyPass.com"
echo -e "     \e[1;32m3)\e[0m Letsencrypt.org"
echo -e "   ------------------------------------"
read -p "   Please select numbers 1-3(Any Button Default Letsencrypt.org) : " acmee
acme1=zerossl
acme2=https://api.buypass.com/acme/directory
acme3=letsencrypt
if [[ $acmee == "1" ]]; then
echo -e "ZeroSSL.com acme is used"
acmeh=$acme1
echo ""
elif [[ $acmee == "2" ]]; then
echo -e "BuyPass.com acme is used"
acmeh=$acme2
elif [[ $acmee == "3" ]]; then
echo -e "Letsencrypt.org acme is used"
acmeh=$acme3
else
echo -e "Default acme(Letsencrypt.org) is used"
acmeh=$acme3
clear
fi
clear
echo start
sleep 0.5
source /var/lib/ipvps.conf
domain=$(cat /usr/local/etc/xray/domain)
clear
systemctl stop xray
systemctl stop nginx
echo -e "\e[0;32mStart renew your Certificate SSL\e[0m"
sleep 1
/root/.acme.sh/acme.sh --upgrade --auto-upgrade
/root/.acme.sh/acme.sh --set-default-ca --server $acmeh
/root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256 --listen-v6
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /usr/local/etc/xray/xray.crt --keypath /usr/local/etc/xray/xray.key --ecc
systemctl start xray
systemctl start nginx
echo Done
sleep 0.5
echo -e "[${GREEN}Done${NC}]"
echo -e "\e[1;32mPort 80 is used\e[0m"
echo -e "\e[1;31mBefore renew domains, make sure port 80 is not used, if you are not sure whether port 80 is in use, please type info to see the active port.\e[0m"
sleep 1
