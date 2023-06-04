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
echo ""
version=$(cat /home/ver)
ver=$( curl https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/versi )
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
# CEK UPDATE
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info1="${Green_font_prefix}($version)${Font_color_suffix}"
Info2="${Green_font_prefix}(LATEST VERSION)${Font_color_suffix}"
Error="Version ${Green_font_prefix}[$ver]${Font_color_suffix} available${Red_font_prefix}[Please Update]${Font_color_suffix}"
version=$(cat /home/ver)
new_version=$( curl https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/versi | grep $version )
#Status Version
if [ $version = $new_version ]; then
sts="${Info2}"
else
sts="${Error}"
fi
clear
echo ""
echo -e "   \e[$line--------------------------------------------------------\e[m"
echo -e "   \e[$back_text                 \e[30m[\e[$box CHECK NEW UPDATE\e[30m ]                   \e[m"
echo -e "   \e[$line--------------------------------------------------------\e[m"
echo -e "   \e[$below VERSION NOW >> $Info1"
echo -e "   \e[$below STATUS UPDATE >> $sts"
echo -e ""
echo -e "       \e[1;31mWould you like to proceed?\e[0m"
echo ""
echo -e "            \e[0;32m[ Select Option ]\033[0m"
echo -e "     \e[$number [1]\e[m \e[$below Script Update Now\e[m"
echo -e "     \e[$number [x]\e[m \e[$below Back To Update Menu\e[m"
echo -e "     \e[$number [y]\e[m \e[$below Back To Main Menu\e[m"
echo -e ""
echo -e "   \e[$line--------------------------------------------------------\e[m"
echo -e "\e[$line"
read -p "Please Choose 1 or x & y : " option2
case $option2 in
1)

clear
echo -e "\e[1;31mUpdate Available Now..\e[m"
echo -e ""
sleep 2
echo -e "\e[1;36mStart Update For New Version, Please Wait..\e[m"
sleep 2
clear
echo -e "\e[0;32mGetting New Version Script..\e[0m"
sleep 1
echo ""
# UPDATE RUN-UPDATE
cd /usr/bin
wget -O run-update "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/update/run-update.sh"
chmod +x run-update
# RUN UPDATE
echo ""
clear
echo -e "\e[0;32mPlease Wait...!\e[0m"
sleep 6
clear
echo ""
echo -e "\e[0;32mNew Version Downloading started!\e[0m"
sleep 2
cd /usr/bin
wget -O update "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/update/update.sh"
wget -O run-update "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/update/run-update.sh"
wget -O message-ssh "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/update/message-ssh.sh"
wget -O change-port "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/change.sh"
wget -O system "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/menu/system.sh"
wget -O menu "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/menu.sh"
wget -O add-host "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/system/add-host.sh"
wget -O check-sc "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/system/running.sh"
wget -O cert "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/cert.sh"
wget -O trojaan "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/menu/trojaan.sh"
wget -O xraay "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/menu/xraay.sh"
wget -O xp "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/xp.sh"
wget -O port-xray "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/change-port/port-xray.sh"
wget -O themes "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/menu/themes.sh"
wget -O autobackup "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/system/autobackup.sh"
wget -O backup "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/system/backup.sh"
wget -O bckp "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/system/bckp.sh"
wget -O restore "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/system/restore.sh"
wget -O ins-xray https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/install/ins-xray.sh

wget -O add-host "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/system/add-host.sh"
wget -O about "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/system/about.sh"
wget -O menu "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/menu.sh"
wget -O add-ssh "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/add-user/add-ssh.sh"
wget -O trial "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/add-user/trial.sh"
wget -O maxisdigi "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/add-user/maxisdigi.sh"
wget -O del-ssh "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/delete-user/del-ssh.sh"
wget -O member "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/member.sh"
wget -O delete "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/delete-user/delete.sh"
wget -O cek-ssh "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/cek-user/cek-ssh.sh"
wget -O restart "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/system/restart.sh"
wget -O speedtest "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/system/speedtest_cli.py"
wget -O ram "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/system/ram.sh"
wget -O renew-ssh "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/renew-user/renew-ssh.sh"
wget -O autokill "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/autokill.sh"
wget -O ceklim "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/cek-user/ceklim.sh"
wget -O tendang "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/tendang.sh"
wget -O clear-log "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/clear-log.sh"
wget -O change-port "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/change.sh"
wget -O port-ovpn "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/change-port/port-ovpn.sh"
wget -O port-ssl "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/change-port/port-ssl.sh"
wget -O port-squid "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/change-port/port-squid.sh"
wget -O port-websocket "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/change-port/port-websocket.sh"
wget -O wbmn "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/webmin.sh"
wget -O xp "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/xp.sh"
wget -O kernel-updt "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/kernel.sh"
wget -O user-list "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/more-option/user-list.sh"
wget -O user-lock "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/more-option/user-lock.sh"
wget -O user-unlock "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/more-option/user-unlock.sh"
wget -O user-password "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/more-option/user-password.sh"
wget -O antitorrent "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/more-option/antitorrent.sh"
wget -O cfa "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/cloud/cfa.sh"
wget -O cfd "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/cloud/cfd.sh"
wget -O cfp "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/cloud/cfp.sh"
wget -O swap "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/swapkvm.sh"
wget -O check-sc "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/system/running.sh"
wget -O m-backup "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/system/m-backup.sh"
wget -O ssh "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/menu/ssh.sh"
wget -O autoreboot "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/system/autoreboot.sh"
wget -O bbr "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/system/bbr.sh"
wget -O port-ohp "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/change-port/port-ohp.sh"
wget -O rclone "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/rclone.conf"
wget -O panel-domain "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/menu/panel-domain.sh"
wget -O dns "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/system/dns.sh"
wget -O nf "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/system/nf.sh"
wget -O addip "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/menu/addip.sh"
wget -O tes "https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/change-port/tes.sh"
chmod +x tes
chmod +x addip
chmod +x add-host
chmod +x menu
chmod +x add-ssh
chmod +x trial
chmod +x maxisdigi
chmod +x del-ssh
chmod +x member
chmod +x delete
chmod +x cek-ssh
chmod +x restart
chmod +x speedtest
chmod +x about
chmod +x autokill
chmod +x tendang
chmod +x ceklim
chmod +x ram
chmod +x renew-ssh
chmod +x clear-log
chmod +x change-port
chmod +x restore
chmod +x port-ovpn
chmod +x port-ssl
chmod +x port-squid
chmod +x port-websocket
chmod +x wbmn
chmod +x xp
chmod +x kernel-updt
chmod +x user-list
chmod +x user-lock
chmod +x user-unlock
chmod +x user-password
chmod +x antitorrent
chmod +x cfa
chmod +x cfd
chmod +x cfp
chmod +x swap
chmod +x check-sc
chmod +x ssh
chmod +x autoreboot
chmod +x bbr
chmod +x port-ohp
chmod +x rclone
chmod +x panel-domain
chmod +x dns
chmod +x nf

chmod +x update
chmod +x run-update
chmod +x message-ssh
chmod +x change-port
chmod +x system
chmod +x menu
chmod +x add-host
chmod +x check-sc
chmod +x cert
chmod +x trojaan
chmod +x xraay
chmod +x xp
chmod +x port-xray
chmod +x themes
chmod +x autobackup
chmod +x backup
chmod +x bckp
chmod +x restore
chmod +x ins-xray
chmod +x running
chmod +x m-backup
clear
echo -e ""
echo -e "\e[0;32mDownloaded successfully!\e[0m"
echo ""
ver=$( curl https://raw.githubusercontent.com/Tarap-Kuhing/multiport/main/versi )
sleep 1
echo -e "\e[0;32mPatching New Update, Please Wait...\e[0m"
echo ""
sleep 2
echo -e "\e[0;32mPatching... OK!\e[0m"
sleep 1
echo ""
echo -e "\e[0;32mSucces Update Script For New Version\e[0m"
cd
echo "$ver" > /home/ver
rm -f update.sh
clear
echo ""
echo -e "\033[0;34m----------------------------------------\033[0m"
echo -e "\E[44;1;39m            SCRIPT UPDATED              \E[0m"
echo -e "\033[0;34m----------------------------------------\033[0m"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
;;
x)
clear
update
;;
y)
clear
menu
;;
*)
clear
echo -e "\e[1;31mPlease Enter Option 1-2 or x & y Only..,Try again, Thank You..\e[0m"
sleep 2
run-update
;;
esac
