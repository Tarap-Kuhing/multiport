#!/bin/bash
# // CODE WARNA
export RED='\e[1;31m'
export GREEN='\e[0;32m'
export BLUE='\e[0;34m'
export NC='\e[0m'

#wget https://github.com/${GitUser}/
GitUser="Tarap-Kuhing"

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

# // GMAIL && DOMAIN
clear
export default_email=$( curl -sS https://raw.githubusercontent.com/${GitUser}/email/main/default.conf )
export emailcf=$(cat /usr/local/etc/xray/email)

clear
echo ""
echo -e "\033[0;34m══════════════════════════════════════════\033[0m"
echo -e "\E[44;1;39m                Add Domain                \E[0m"
echo -e "\033[0;34m══════════════════════════════════════════\033[0m"
echo ""

echo "Please Input Your Pointing Domain In Cloudflare "
read -rp "Domain/Host: " -e host
echo "IP=$host" >> /var/lib/ipvps.conf
echo "$host" > /usr/local/etc/xray/domain

export dom=$(cat /etc/xray/domain)
export domain=$(cat /usr/local/etc/xray/domain)

sed -i "s/sshws.${dom}/sshws.${domain}/g" /usr/local/etc/xray/config.json;
rm -f /etc/xray/domain;
echo "$host" > /etc/xray/domain

echo ""
echo -e "\e[1;32m════════════════════════════════════════════════════════════\e[0m"
echo ""
echo -e "   \e[1;32mPlease enter your email Domain/Cloudflare."
echo -e "   \e[1;31m(Press ENTER for default email)\e[0m"

# // EMAIL
read -p "   Email : " email
default=${default_email}
new_email=$email
if [[ $email == "" ]]; then
sts=$default_email
else
sts=$new_email
fi

# // GMAIL
rm -f /usr/local/etc/xray/email
echo $sts > /usr/local/etc/xray/email
echo -e "[${GREEN} Success Add Email ${NC}]"
sleep 0.3

# // UPDATE CERT SSL
clear
echo
echo "Automatical Update Your Certificate SSL"
sleep 0.3
echo Starting Update SSL Certificate
sleep 0.3

# // STOP XRAY
systemctl stop xray.service
systemctl stop xray@none

# // GENERATE CERT
/root/.acme.sh/acme.sh --upgrade --auto-upgrade
/root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
/root/.acme.sh/acme.sh --issue -d $domain -d sshws.$domain --standalone -k ec-256 --listen-v6
~/.acme.sh/acme.sh --installcert -d $domain -d sshws.$domain --fullchainpath /usr/local/etc/xray/xray.crt --keypath /usr/local/etc/xray/xray.key --ecc

# // RESTART XRAY
systemctl restart xray.service
systemctl restart xray@none

clear
echo -e ""
echo -e "\033[0;34m══════════════════════════════════════════\033[0m"
echo -e "\E[44;1;39m        PERTUKARAN DOMAIN SELESAI         \E[0m"
echo -e "\033[0;34m══════════════════════════════════════════\033[0m"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
