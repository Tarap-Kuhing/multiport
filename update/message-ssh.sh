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
# Status Version
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
InfoD="Default Version ${Green_font_prefix}[ON]${Font_color_suffix}"
Info1="Version 1 ${Green_font_prefix}[ON]${Font_color_suffix}"
Info2="Version 2 ${Green_font_prefix}[ON]${Font_color_suffix}"
Info3="Version 3 ${Green_font_prefix}[ON]${Font_color_suffix}"
Info4="Version 4 ${Green_font_prefix}[ON]${Font_color_suffix}"
Info5="Custom Version ${Green_font_prefix}[ON]${Font_color_suffix}"
Error="Banner SSH ${Red_font_prefix}[OFF]${Font_color_suffix}"
cek=$(cat /home/bannerssh)
function defaultv () {
rm -f /etc/issue.net
wget -O /etc/issue.net https://raw.githubusercontent.com/${GitUser}/menu/main/banner/bannersshDefault.conf && chmod +x /etc/issue.net
echo "0.1" > /home/bannerssh
clear
echo -e "Succesfully Use Default Version."
echo -e "\e[0;32mDone\e[0m"
echo -e " \e[1;31mReboot 3 Sec\e[0m"
sleep 3
reboot
}
function server_message_ssh1 () {
rm -f /etc/issue.net
wget -O /etc/issue.net https://raw.githubusercontent.com/Tarap-Kuhing/menu/main/banner/bannerssh1.conf && chmod +x /etc/issue.net
echo "1" > /home/bannerssh
clear
echo -e "Succesfully Change Server Message Version 1 For SSH."
echo -e "\e[0;32mDone\e[0m"
echo -e " \e[1;31mReboot 3 Sec\e[0m"
sleep 3
reboot
}
function server_message_ssh2 () {
rm -f /etc/issue.net
wget -O /etc/issue.net https://raw.githubusercontent.com/Tarap-Kuhing/menu/main/banner/bannerssh2.conf && chmod +x /etc/issue.net
echo "2" > /home/bannerssh
clear
echo -e "Succesfully Change Server Message Version 2 For SSH."
echo -e "\e[0;32mDone\e[0m"
echo -e " \e[1;31mReboot 3 Sec\e[0m"
sleep 3
reboot
}
function server_message_ssh3 () {
rm -f /etc/issue.net
wget -O /etc/issue.net https://raw.githubusercontent.com/Tarap-Kuhing/menu/main/banner/bannerssh3.conf && chmod +x /etc/issue.net
echo "3" > /home/bannerssh
clear
echo -e "Succesfully Change Server Message Version 3 For SSH."
echo -e "\e[0;32mDone\e[0m"
echo -e " \e[1;31mReboot 3 Sec\e[0m"
sleep 3
reboot
}
function server_message_ssh4 () {
rm -f /etc/issue.net
wget -O /etc/issue.net https://raw.githubusercontent.com/Tarap-Kuhing/menu/main/banner/bannerssh4.conf && chmod +x /etc/issue.net
echo "4" > /home/bannerssh
clear
echo -e "Succesfully Change Server Message Version 4 For SSH."
echo -e "\e[0;32mDone\e[0m"
echo -e " \e[1;31mReboot 3 Sec\e[0m"
sleep 3
reboot
}
function server_message_ssh5 () {
echo "5" > /home/bannerssh
nano /etc/issue.net
echo -e "Succesfully Customize Server Message For SSH."
echo -e "\e[0;32mDone\e[0m"
echo -e " \e[1;31mReboot 3 Sec\e[0m"
sleep 3
reboot
}
function stop () {
rm -f /etc/issue.net
sleep 0.5
echo > /home/bannerssh
echo -e "Server Message SSH has been successfully Turn Off."
echo -e "\e[0;32mDone\e[0m"
echo -e " \e[1;31mReboot 3 Sec\e[0m"
sleep 3
reboot
}

#Status Server Message
if [[ "$cek" = "0.1" ]]; then
sts="${InfoD}"
elif [[ "$cek" = "1" ]]; then
sts="${Info1}"
elif [[ "$cek" = "2" ]]; then
sts="${Info2}"
elif [[ "$cek" = "3" ]]; then
sts="${Info3}"
elif [[ "$cek" = "4" ]]; then
sts="${Info4}"
elif [[ "$cek" = "5" ]]; then
sts="${Info5}"
else
sts="${Error}"
fi
clear
echo ""
figlet " BANNER  SSH" | lolcat
echo -e "  ${BLUE}.---------------------------------------------------------. ${NC}" | lolcat
echo -e "  |              BANNER/SERVER MESSAGE FOR SSH              |" | lolcat
echo -e "  ${BLUE}'---------------------------------------------------------' ${NC}" | lolcat
echo -e "    \e[0;33mSTATUS BANNER\e[0;36m(USED) \e[0;33m:\e[0m $sts"
echo -e ""
echo -e "      \e[0;36m1.\e[0m Set Default Banner"
echo -e "      \e[0;36m2.\e[0m Set Banner Version 1"
echo -e "      \e[0;36m3.\e[0m Set Banner Version 2"
echo -e "      \e[0;36m4.\e[0m Set Banner Version 3"
echo -e "      \e[0;36m5.\e[0m Set Banner Version 4"
echo -e "      \e[0;36m6.\e[0m Edit Banner SSH"
echo -e "      \e[0;36m7.\e[0m Turn Off Banner SSH"
echo -e ""
echo -e "   ${BLUE}--------------------------------------------------------- ${NC}" | lolcat
echo -e "      \e[0;36mx.\e[0m Back To Update Script Menu"
echo -e "      \e[0;36my.\e[0m Back To Main Menu"
echo -e ""
read -rp "  Please Enter 1-7 or x & y : " -e num
if [[ "$num" = "1" ]]; then
defaultv
elif [[ "$num" = "2" ]]; then
server_message_ssh1
elif [[ "$num" = "3" ]]; then
server_message_ssh2
elif [[ "$num" = "4" ]]; then
server_message_ssh3
elif [[ "$num" = "5" ]]; then
server_message_ssh4
elif [[ "$num" = "6" ]]; then
server_message_ssh5
elif [[ "$num" = "8" ]]; then
stop
elif [[ "$num" = "x" ]]; then
update
elif [[ "$num" = "y" ]]; then
menu
else
clear
echo -e "\e[1;31mYou Entered The Wrong Number, Please Try Again!\e[0m"
sleep 2
message-ssh
fi
