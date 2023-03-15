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


# // PROVIDED
clear
source /var/lib/ipvps.conf
export creditt=$(cat /root/provided)

# // BANNER COLOUR
export banner_colour=$(cat /etc/banner)

# // TEXT ON BOX COLOUR
export box=$(cat /etc/box)

# // LINE COLOUR
export line=$(cat /etc/line)

# // TEXT COLOUR ON TOP
export text=$(cat /etc/text)

# // TEXT COLOUR BELOW
export below=$(cat /etc/below)

# // BACKGROUND TEXT COLOUR
export back_text=$(cat /etc/back)

# // NUMBER COLOUR
export number=$(cat /etc/number)

# // TOTAL ACC CREATE VMESS WS
export total1=$(grep -c -E "^#vms " "/usr/local/etc/xray/vmess.json")

# // TOTAL ACC CREATE  VLESS WS
export total2=$(grep -c -E "^#vls " "/usr/local/etc/xray/vless.json")

# // TOTAL ACC CREATE  VLESS TCP XTLS
export total3=$(grep -c -E "^#vxtls " "/usr/local/etc/xray/config.json")
if [[ "$IP" = "" ]]; then
     domain=$(cat /usr/local/etc/xray/domain)
else
     domain=$IP
fi

# // FUCTION ADD USER
function menu1 () {
clear
tls="$(cat ~/log-install.txt | grep -w "Vmess Ws Tls" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Vmess Ws None Tls" | cut -d: -f2|sed 's/ //g')"
echo -e   "  \e[$line═══════════════════════════════════════════════════════\e[m"
echo -e   "  \e[$back_text           \e[30m[\e[$box CREATE USER XRAY VMESS WS TLS\e[30m ]\e[1m           \e[m"
echo -e   "  \e[$line═══════════════════════════════════════════════════════\e[m"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "   Username: " -e user
		CLIENT_EXISTS=$(grep -w $user /usr/local/etc/xray/vmess.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			exit 1
		fi
	done
export patchtls=/vmess
export patchnontls=/vmess
export uuid=$(cat /proc/sys/kernel/random/uuid)

#read -p "   Bug Address    : " address
#read -p "   Bug SNI/Host   : " sni
#read -p "   Expired (days) : " masaaktif

#bug_addr=${address}.
#bug_addr2=$address
#if [[ $address == "" ]]; then
#sts=$bug_addr2
#else
#sts=$bug_addr
#fi

export exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
export harini=`date -d "0 days" +"%Y-%m-%d"`

sed -i '/#xray-vmess-tls$/a\#vms '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /usr/local/etc/xray/vmess.json
sed -i '/#xray-vmess-nontls$/a\#vms '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /usr/local/etc/xray/vmessnone.json

cat>/usr/local/etc/xray/$user-tls.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${tls}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "$patchtls",
      "type": "none",
      "host": "$sni",
      "tls": "tls",
}
EOF
cat>/usr/local/etc/xray/$user-none.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${none}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "$patchnontls",
      "type": "none",
      "host": "$sni",
      "tls": "none"
}
EOF

cat > /usr/local/etc/xray/$user-clash-for-android.yaml <<-END
# Generated Vmess with Clash For Android
# Generated by Dyanvx199
# Credit : Clash For Android

# CONFIG CLASH VMESS
port: 7890
socks-port: 7891
allow-lan: true
mode: Rule
log-level: info
external-controller: 127.0.0.1:9090
proxies:
  - {name: $user, server: ${sts}${domain}, port: $none, type: vmess, uuid: $uuid, alterId: 0, cipher: auto, tls: false, network: ws, ws-path: $patchnontls, ws-headers: {Host: $sni}}
proxy-groups:
  - name: ðŸš€ èŠ‚ç‚¹é€‰æ‹©
    type: select
    proxies:
      - â™»ï¸ è‡ªåŠ¨é€‰æ‹©
      - DIRECT
      - $user
  - name: â™»ï¸ è‡ªåŠ¨é€‰æ‹©
    type: url-test
    url: http://www.gstatic.com/generate_204
    interval: 300
    tolerance: 50
    proxies:
      - $user
  - name: ðŸŒ å›½å¤–åª’ä½“
    type: select
    proxies:
      - ðŸš€ èŠ‚ç‚¹é€‰æ‹©
      - â™»ï¸ è‡ªåŠ¨é€‰æ‹©
      - ðŸŽ¯ å…¨çƒç›´è¿ž
      - $user
  - name: ðŸ“² ç”µæŠ¥ä¿¡æ¯
    type: select
    proxies:
      - ðŸš€ èŠ‚ç‚¹é€‰æ‹©
      - ðŸŽ¯ å…¨çƒç›´è¿ž
      - $user
  - name: â“‚ï¸ å¾®è½¯æœåŠ¡
    type: select
    proxies:
      - ðŸŽ¯ å…¨çƒç›´è¿ž
      - ðŸš€ èŠ‚ç‚¹é€‰æ‹©
      - $user
  - name: ðŸŽ è‹¹æžœæœåŠ¡
    type: select
    proxies:
      - ðŸš€ èŠ‚ç‚¹é€‰æ‹©
      - ðŸŽ¯ å…¨çƒç›´è¿ž
      - $user
  - name: ðŸ“¢ è°·æ­ŒFCM
    type: select
    proxies:
      - ðŸš€ èŠ‚ç‚¹é€‰æ‹©
      - ðŸŽ¯ å…¨çƒç›´è¿ž
      - â™»ï¸ è‡ªåŠ¨é€‰æ‹©
      - $user
  - name: ðŸŽ¯ å…¨çƒç›´è¿ž
    type: select
    proxies:
      - DIRECT
      - ðŸš€ èŠ‚ç‚¹é€‰æ‹©
      - â™»ï¸ è‡ªåŠ¨é€‰æ‹©
  - name: ðŸ›‘ å…¨çƒæ‹¦æˆª
    type: select
    proxies:
      - REJECT
      - DIRECT
  - name: ðŸƒ åº”ç”¨å‡€åŒ–
    type: select
    proxies:
      - REJECT
      - DIRECT
  - name: ðŸŸ æ¼ç½‘ä¹‹é±¼
    type: select
    proxies:
      - ðŸš€ èŠ‚ç‚¹é€‰æ‹©
      - ðŸŽ¯ å…¨çƒç›´è¿ž
      - â™»ï¸ è‡ªåŠ¨é€‰æ‹©
      - $user
END
# // masukkan payloadnya ke dalam config yaml
cat /etc/openvpn/server/cll.key >> /usr/local/etc/xray/$user-clash-for-android.yaml

# // Copy config Yaml client ke home directory root agar mudah didownload ( YAML )
cp /usr/local/etc/xray/$user-clash-for-android.yaml /home/vps/public_html/$user-clash-for-android.yaml

export vmess_base641=$( base64 -w 0 <<< $vmess_json1)
export vmess_base642=$( base64 -w 0 <<< $vmess_json2)
export vmesslink1="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-tls.json)"
export vmesslink2="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-none.json)"

systemctl restart xray@vmess
systemctl restart xray@vmessnone
service cron restart

clear
echo -e ""
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "\e[$back_text      \e[30m[\e[$box XRAY VMESS WS\e[30m ]\e[1m          \e[m"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Remarks        : ${user}"
echo -e "Domain         : ${domain}"
echo -e "IP/Host        : $MYIP"
echo -e "Port TLS       : ${tls}"
echo -e "Port None TLS  : ${none}"
echo -e "User ID        : ${uuid}"
echo -e "Security       : Auto"
echo -e "Network        : Websocket"
echo -e "Path Tls       : $patchtls"
echo -e "Path None Tls  : $patchnontls"
echo -e "allowInsecure  : True/allow"
echo -e "Support Yaml   : YES"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Pantang Larang $creditt Shop"
echo -e "‼️Aktiviti Berikut Adalah Dilarang(ID akan di ban tanpa notis & tiada refund)"
echo -e "\e[31m❌ Torrent (p2p, streaming p2p)"
echo -e "\e[31m❌ PS4"
echo -e "\e[31m❌ Porn"
echo -e "\e[31m❌ Spam Bug"
echo -e "\e[31m❌ Ddos Server"
echo -e "\e[31m❌ Mining Bitcoins"
echo -e "\e[31m❌ Abuse Usage"
echo -e "\e[31m❌ Multi-Login ID"
echo -e "\e[31m❌ Sharing Premium Config\e[m"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link TLS      : ${vmesslink1}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link None TLS : ${vmesslink2}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link Yaml  : http://$MYIP:81/$user-clash-for-android.yaml"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Created   : $harini"
echo -e "Expired   : $exp"
echo -e "Script By $creditt"
echo ""
read -n 1 -s -r -p "Press any key to back on menu xray"
xraay
}

# // TRIAL USER
function menu2 () {
clear
tls="$(cat ~/log-install.txt | grep -w "Vmess Ws Tls" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Vmess Ws None Tls" | cut -d: -f2|sed 's/ //g')"
echo -e   "  \e[$line═══════════════════════════════════════════════════════\e[m"
echo -e   "  \e[$back_text           \e[30m[\e[$box TRIAL USER XRAY VMESS WS TLS\e[30m ]\e[1m            \e[m"
echo -e   "  \e[$line═══════════════════════════════════════════════════════\e[m"

# // Exp
export masaaktif="1"
export exp=$(date -d "$masaaktif days" +"%Y-%m-%d")

# // Make Random Username
export user=Trial`</dev/urandom tr -dc X-Z0-9 | head -c4`
export patchtls=/vmess
export patchnontls=/vmess
export uuid=$(cat /proc/sys/kernel/random/uuid)

#read -p "   Bug Address (Example: www.google.com) : " address
#read -p "   Bug SNI/Host (Example : m.facebook.com) : " sni

#bug_addr=${address}.
#bug_addr2=$address
#if [[ $address == "" ]]; then
#sts=$bug_addr2
#else
#sts=$bug_addr
#fi

export harini=`date -d "0 days" +"%Y-%m-%d"`

sed -i '/#xray-vmess-tls$/a\#vms '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /usr/local/etc/xray/vmess.json
sed -i '/#xray-vmess-nontls$/a\#vms '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /usr/local/etc/xray/vmessnone.json

cat>/usr/local/etc/xray/$user-tls.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${tls}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "$patchtls",
      "type": "none",
      "host": "$sni",
      "tls": "tls",
}
EOF
cat>/usr/local/etc/xray/$user-none.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${none}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "$patchnontls",
      "type": "none",
      "host": "$sni",
      "tls": "none"
}
EOF

cat > /usr/local/etc/xray/$user-clash-for-android.yaml <<-END
# Generated Vmess with Clash For Android
# Generated by Dyanvx199
# Credit : Clash For Android

# CONFIG CLASH VMESS
port: 7890
socks-port: 7891
allow-lan: true
mode: Rule
log-level: info
external-controller: 127.0.0.1:9090
proxies:
  - {name: $user, server: ${sts}${domain}, port: $none, type: vmess, uuid: $uuid, alterId: 0, cipher: auto, tls: false, network: ws, ws-path: $patchnontls, ws-headers: {Host: $sni}}
proxy-groups:
  - name: ðŸš€ èŠ‚ç‚¹é€‰æ‹©
    type: select
    proxies:
      - â™»ï¸ è‡ªåŠ¨é€‰æ‹©
      - DIRECT
      - $user
  - name: â™»ï¸ è‡ªåŠ¨é€‰æ‹©
    type: url-test
    url: http://www.gstatic.com/generate_204
    interval: 300
    tolerance: 50
    proxies:
      - $user
  - name: ðŸŒ å›½å¤–åª’ä½“
    type: select
    proxies:
      - ðŸš€ èŠ‚ç‚¹é€‰æ‹©
      - â™»ï¸ è‡ªåŠ¨é€‰æ‹©
      - ðŸŽ¯ å…¨çƒç›´è¿ž
      - $user
  - name: ðŸ“² ç”µæŠ¥ä¿¡æ¯
    type: select
    proxies:
      - ðŸš€ èŠ‚ç‚¹é€‰æ‹©
      - ðŸŽ¯ å…¨çƒç›´è¿ž
      - $user
  - name: â“‚ï¸ å¾®è½¯æœåŠ¡
    type: select
    proxies:
      - ðŸŽ¯ å…¨çƒç›´è¿ž
      - ðŸš€ èŠ‚ç‚¹é€‰æ‹©
      - $user
  - name: ðŸŽ è‹¹æžœæœåŠ¡
    type: select
    proxies:
      - ðŸš€ èŠ‚ç‚¹é€‰æ‹©
      - ðŸŽ¯ å…¨çƒç›´è¿ž
      - $user
  - name: ðŸ“¢ è°·æ­ŒFCM
    type: select
    proxies:
      - ðŸš€ èŠ‚ç‚¹é€‰æ‹©
      - ðŸŽ¯ å…¨çƒç›´è¿ž
      - â™»ï¸ è‡ªåŠ¨é€‰æ‹©
      - $user
  - name: ðŸŽ¯ å…¨çƒç›´è¿ž
    type: select
    proxies:
      - DIRECT
      - ðŸš€ èŠ‚ç‚¹é€‰æ‹©
      - â™»ï¸ è‡ªåŠ¨é€‰æ‹©
  - name: ðŸ›‘ å…¨çƒæ‹¦æˆª
    type: select
    proxies:
      - REJECT
      - DIRECT
  - name: ðŸƒ åº”ç”¨å‡€åŒ–
    type: select
    proxies:
      - REJECT
      - DIRECT
  - name: ðŸŸ æ¼ç½‘ä¹‹é±¼
    type: select
    proxies:
      - ðŸš€ èŠ‚ç‚¹é€‰æ‹©
      - ðŸŽ¯ å…¨çƒç›´è¿ž
      - â™»ï¸ è‡ªåŠ¨é€‰æ‹©
      - $user
END
# // masukkan payloadnya ke dalam config yaml
cat /etc/openvpn/server/cll.key >> /usr/local/etc/xray/$user-clash-for-android.yaml

# // Copy config Yaml client ke home directory root agar mudah didownload ( YAML )
cp /usr/local/etc/xray/$user-clash-for-android.yaml /home/vps/public_html/$user-clash-for-android.yaml

export vmess_base641=$( base64 -w 0 <<< $vmess_json1)
export vmess_base642=$( base64 -w 0 <<< $vmess_json2)
export vmesslink1="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-tls.json)"
export vmesslink2="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-none.json)"

systemctl restart xray@vmess
systemctl restart xray@vmessnone
service cron restart

clear
echo -e ""
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "\e[$back_text     \e[30m[\e[$box TRIAL XRAY VMESS WS\e[30m ]\e[1m     \e[m"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Remarks        : ${user}"
echo -e "Domain         : ${domain}"
echo -e "IP/Host        : $MYIP"
echo -e "Port TLS       : ${tls}"
echo -e "Port None TLS  : ${none}"
echo -e "User ID        : ${uuid}"
echo -e "Security       : Auto"
echo -e "Network        : Websocket"
echo -e "Path Tls       : $patchtls"
echo -e "Path None Tls  : $patchnontls"
echo -e "allowInsecure  : True/allow"
echo -e "Support Yaml   : YES"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Pantang Larang $creditt Shop"
echo -e "‼️Aktiviti Berikut Adalah Dilarang(ID akan di ban tanpa notis & tiada refund)"
echo -e "\e[31m❌ Torrent (p2p, streaming p2p)"
echo -e "\e[31m❌ PS4"
echo -e "\e[31m❌ Porn"
echo -e "\e[31m❌ Spam Bug"
echo -e "\e[31m❌ Ddos Server"
echo -e "\e[31m❌ Mining Bitcoins"
echo -e "\e[31m❌ Abuse Usage"
echo -e "\e[31m❌ Multi-Login ID"
echo -e "\e[31m❌ Sharing Premium Config\e[m"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link TLS      : ${vmesslink1}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link None TLS : ${vmesslink2}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link Yaml  : http://$MYIP:81/$user-clash-for-android.yaml"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Created   : $harini"
echo -e "Expired   : $exp"
echo -e "Script By $creditt"
echo ""
read -n 1 -s -r -p "Press any key to back on menu xray"
xraay
}

# FUCTION DELETE USER
function menu3 () {
clear
NUMBER_OF_CLIENTS=$(grep -c -E "^#vms " "/usr/local/etc/xray/vmess.json")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		echo ""
		echo "You have no existing clients!"
		exit 1
	fi

	clear
	echo " Delete User Xray Vmess Ws"
	echo " Select the existing client you want to remove"
	echo " Press CTRL+C to return"
	echo " ==============================="
	echo "     No  Expired   User"
	grep -E "^#vms " "/usr/local/etc/xray/vmess.json" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
export harini=$(grep -E "^#vms " "/usr/local/etc/xray/vmess.json" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)
export uuid=$(grep -E "^#vms " "/usr/local/etc/xray/vmess.json" | cut -d ' ' -f 5 | sed -n "${CLIENT_NUMBER}"p)
export user=$(grep -E "^#vms " "/usr/local/etc/xray/vmess.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
export exp=$(grep -E "^#vms " "/usr/local/etc/xray/vmess.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)

sed -i "/^#vms $user $exp $harini $uuid/,/^},{/d" /usr/local/etc/xray/vmess.json
sed -i "/^#vms $user $exp $harini $uuid/,/^},{/d" /usr/local/etc/xray/vmessnone.json

rm -f /usr/local/etc/xray/$user-tls.json
rm -f /usr/local/etc/xray/$user-none.json
rm -f /usr/local/etc/xray/$user-clash-for-android.yaml
rm -f /home/vps/public_html/$user-clash-for-android.yaml

systemctl restart xray@vmess
systemctl restart xray@vmessnone

clear
echo " XRAY VMESS WS Account Deleted Successfully"
echo " =========================="
echo " Client Name : $user"
echo " Expired On  : $exp"
echo " =========================="
echo ""
read -n 1 -s -r -p "Press any key to back on menu xray"
xraay
}
# FUCTION RENEW USER
function menu4 () {
clear
NUMBER_OF_CLIENTS=$(grep -c -E "^#vms " "/usr/local/etc/xray/vmess.json")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		clear
		echo ""
		echo "You have no existing clients!"
		exit 1
	fi

	clear
	echo "Renew User Xray Vmess Ws"
	echo "Select the existing client you want to renew"
	echo " Press CTRL+C to return"
	echo -e "==============================="
	grep -E "^#vms " "/usr/local/etc/xray/vmess.json" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
read -p "Expired (days): " masaaktif
export harini=$(grep -E "^#vms " "/usr/local/etc/xray/vmess.json" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)
export uuid=$(grep -E "^#vms " "/usr/local/etc/xray/vmess.json" | cut -d ' ' -f 5 | sed -n "${CLIENT_NUMBER}"p)
export user=$(grep -E "^#vms " "/usr/local/etc/xray/vmess.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
export exp=$(grep -E "^#vms " "/usr/local/etc/xray/vmess.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
export now=$(date +%Y-%m-%d)
export d1=$(date -d "$exp" +%s)
export d2=$(date -d "$now" +%s)
export exp2=$(( (d1 - d2) / 86400 ))
export exp3=$(($exp2 + $masaaktif))
export exp4=`date -d "$exp3 days" +"%Y-%m-%d"`

sed -i "s/#vms $user $exp $harini $uuid/#vms $user $exp4 $harini $uuid/g" /usr/local/etc/xray/vmess.json
sed -i "s/#vms $user $exp $harini $uuid/#vms $user $exp4 $harini $uuid/g" /usr/local/etc/xray/vmessnone.json

systemctl restart xray@vmess
systemctl restart xray@vmessnone
service cron restart

clear
echo ""
echo " VMESS WS & Clash Account Was Successfully Renewed"
echo " =========================="
echo " Client Name : $user"
echo " Expired On  : $exp4"
echo " =========================="
echo ""
read -n 1 -s -r -p "Press any key to back on menu xray"
xraay
}

# show user
function menu5 () {
clear
tls="$(cat ~/log-install.txt | grep -w "Vmess Ws Tls" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Vmess Ws None Tls" | cut -d: -f2|sed 's/ //g')"
NUMBER_OF_CLIENTS=$(grep -c -E "^#vms " "/usr/local/etc/xray/vmess.json")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		clear
		echo ""
		echo "You have no existing clients!"
		exit 1
	fi

	clear
	echo ""
	echo "SHOW USER XRAY VMESS WS"
	echo "Select the existing client you want to renew"
	echo " Press CTRL+C to return"
	echo -e "==============================="
	grep -E "^#vms " "/usr/local/etc/xray/vmess.json" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
export patchtls=/vmess
export patchnontls=/vmess
export user=$(grep -E "^#vms " "/usr/local/etc/xray/vmess.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
export harini=$(grep -E "^#vms " "/usr/local/etc/xray/vmess.json" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)
export exp=$(grep -E "^#vms " "/usr/local/etc/xray/vmess.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
export uuid=$(grep -E "^#vms " "/usr/local/etc/xray/vmess.json" | cut -d ' ' -f 5 | sed -n "${CLIENT_NUMBER}"p)
cat>/usr/local/etc/xray/$user-tls.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${tls}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "$patchtls",
      "type": "none",
      "host": "bug.com",
      "tls": "tls",
}
EOF
cat>/usr/local/etc/xray/$user-none.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${none}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "$patchnontls",
      "type": "none",
      "host": "bug.com",
      "tls": "none"
}
EOF
cat > /usr/local/etc/xray/$user-clash-for-android.yaml <<-END
# Generated Vmess with Clash For Android
# Generated by Dyanvx199
# Credit : Clash For Android

# CONFIG CLASH VMESS
port: 7890
socks-port: 7891
allow-lan: true
mode: Rule
log-level: info
external-controller: 127.0.0.1:9090
proxies:
  - {name: $user, server: ${sts}${domain}, port: $none, type: vmess, uuid: $uuid, alterId: 0, cipher: auto, tls: false, network: ws, ws-path: $patchnontls, ws-headers: {Host: bug.com}}
proxy-groups:
  - name: ðŸš€ èŠ‚ç‚¹é€‰æ‹©
    type: select
    proxies:
      - â™»ï¸ è‡ªåŠ¨é€‰æ‹©
      - DIRECT
      - $user
  - name: â™»ï¸ è‡ªåŠ¨é€‰æ‹©
    type: url-test
    url: http://www.gstatic.com/generate_204
    interval: 300
    tolerance: 50
    proxies:
      - $user
  - name: ðŸŒ å›½å¤–åª’ä½“
    type: select
    proxies:
      - ðŸš€ èŠ‚ç‚¹é€‰æ‹©
      - â™»ï¸ è‡ªåŠ¨é€‰æ‹©
      - ðŸŽ¯ å…¨çƒç›´è¿ž
      - $user
  - name: ðŸ“² ç”µæŠ¥ä¿¡æ¯
    type: select
    proxies:
      - ðŸš€ èŠ‚ç‚¹é€‰æ‹©
      - ðŸŽ¯ å…¨çƒç›´è¿ž
      - $user
  - name: â“‚ï¸ å¾®è½¯æœåŠ¡
    type: select
    proxies:
      - ðŸŽ¯ å…¨çƒç›´è¿ž
      - ðŸš€ èŠ‚ç‚¹é€‰æ‹©
      - $user
  - name: ðŸŽ è‹¹æžœæœåŠ¡
    type: select
    proxies:
      - ðŸš€ èŠ‚ç‚¹é€‰æ‹©
      - ðŸŽ¯ å…¨çƒç›´è¿ž
      - $user
  - name: ðŸ“¢ è°·æ­ŒFCM
    type: select
    proxies:
      - ðŸš€ èŠ‚ç‚¹é€‰æ‹©
      - ðŸŽ¯ å…¨çƒç›´è¿ž
      - â™»ï¸ è‡ªåŠ¨é€‰æ‹©
      - $user
  - name: ðŸŽ¯ å…¨çƒç›´è¿ž
    type: select
    proxies:
      - DIRECT
      - ðŸš€ èŠ‚ç‚¹é€‰æ‹©
      - â™»ï¸ è‡ªåŠ¨é€‰æ‹©
  - name: ðŸ›‘ å…¨çƒæ‹¦æˆª
    type: select
    proxies:
      - REJECT
      - DIRECT
  - name: ðŸƒ åº”ç”¨å‡€åŒ–
    type: select
    proxies:
      - REJECT
      - DIRECT
  - name: ðŸŸ æ¼ç½‘ä¹‹é±¼
    type: select
    proxies:
      - ðŸš€ èŠ‚ç‚¹é€‰æ‹©
      - ðŸŽ¯ å…¨çƒç›´è¿ž
      - â™»ï¸ è‡ªåŠ¨é€‰æ‹©
      - $user
END
# // masukkan payloadnya ke dalam config yaml
cat /etc/openvpn/server/cll.key >> /usr/local/etc/xray/$user-clash-for-android.yaml

# // Copy config Yaml client ke home directory root agar mudah didownload ( YAML )
cp /usr/local/etc/xray/$user-clash-for-android.yaml /home/vps/public_html/$user-clash-for-android.yaml
export vmess_base641=$( base64 -w 0 <<< $vmess_json1)
export vmess_base642=$( base64 -w 0 <<< $vmess_json2)
export vmesslink1="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-tls.json)"
export vmesslink2="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-none.json)"

clear
echo -e ""
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "\e[$back_text      \e[30m[\e[$box XRAY VMESS WS\e[30m ]\e[1m          \e[m"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Remarks        : ${user}"
echo -e "Domain         : ${domain}"
echo -e "IP/Host        : $MYIP"
echo -e "Port TLS       : ${tls}"
echo -e "Port None TLS  : ${none}"
echo -e "User ID        : ${uuid}"
echo -e "Security       : Auto"
echo -e "Network        : Websocket"
echo -e "Path Tls       : $patchtls"
echo -e "Path None Tls  : $patchnontls"
echo -e "allowInsecure  : True/allow"
echo -e "Support Yaml   : YES"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Pantang Larang $creditt Shop"
echo -e "‼️Aktiviti Berikut Adalah Dilarang(ID akan di ban tanpa notis & tiada refund)"
echo -e "\e[31m❌ Torrent (p2p, streaming p2p)"
echo -e "\e[31m❌ PS4"
echo -e "\e[31m❌ Porn"
echo -e "\e[31m❌ Spam Bug"
echo -e "\e[31m❌ Ddos Server"
echo -e "\e[31m❌ Mining Bitcoins"
echo -e "\e[31m❌ Abuse Usage"
echo -e "\e[31m❌ Multi-Login ID"
echo -e "\e[31m❌ Sharing Premium Config\e[m"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link TLS      : ${vmesslink1}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link None TLS : ${vmesslink2}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link Yaml  : http://$MYIP:81/$user-clash-for-android.yaml"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Created   : $harini"
echo -e "Expired   : $exp"
echo -e "Script By $creditt"
echo ""
read -n 1 -s -r -p "Press any key to back on menu xray"
xraay
}

# FUCTION CEK USER
function menu6 () {
clear
echo -n > /tmp/other.txt
data=( `cat /usr/local/etc/xray/vmess.json | grep '^#vms' | cut -d ' ' -f 2`);
echo -e "\033[0;34m══════════════════════════════════════════\033[0m"
echo -e "\\E[0;44;37m      ⇱ XRAY Vmess WS User Login  ⇲       \E[0m"
echo -e "\033[0;34m══════════════════════════════════════════\033[0m"
for akun in "${data[@]}"
do
if [[ -z "$akun" ]]; then
akun="tidakada"
fi
echo -n > /tmp/ipvmess.txt
data2=( `netstat -anp | grep ESTABLISHED | grep tcp6 | grep xray | awk '{print $5}' | cut -d: -f1 | sort | uniq`);
for ip in "${data2[@]}"
do
jum=$(cat /var/log/xray/access.log | grep -w $akun | awk '{print $3}' | cut -d: -f1 | grep -w $ip | sort | uniq)
if [[ "$jum" = "$ip" ]]; then
echo "$jum" >> /tmp/ipvmess.txt
else
echo "$ip" >> /tmp/other.txt
fi
jum2=$(cat /tmp/ipvmess.txt)
sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
done
jum=$(cat /tmp/ipvmess.txt)
if [[ -z "$jum" ]]; then
echo > /dev/null
else
jum2=$(cat /tmp/ipvmess.txt | nl)
echo "user : $akun";
echo "$jum2";
echo ""
echo -e "\e[$line══════════════════════════════════════════\e[m"
fi
rm -rf /tmp/ipvmess.txt
rm -rf /tmp/other.txt
done
echo ""
read -n 1 -s -r -p "Press any key to back on menu xray"
xraay
}

# ADD USER VLESS WS
function menu7 () {
clear
tls="$(cat ~/log-install.txt | grep -w "Vless Ws Tls" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Vless Ws None Tls" | cut -d: -f2|sed 's/ //g')"
echo -e   "  \e[$line═══════════════════════════════════════════════════════\e[m"
echo -e   "  \e[$back_text           \e[30m[\e[$box CREATE USER XRAY VLESS WS TLS\e[30m ]\e[1m           \e[m"
echo -e   "  \e[$line═══════════════════════════════════════════════════════\e[m"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "   Username: " -e user
		CLIENT_EXISTS=$(grep -w $user /usr/local/etc/xray/vless.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			exit 1
		fi
	done
export patchtls=/vless
export patchnontls=/vless
export uuid=$(cat /proc/sys/kernel/random/uuid)

#read -p "   Bug Address (Example: www.google.com) : " address
#read -p "   Bug SNI/Host (Example : m.facebook.com) : " sni
#read -p "   Expired (days) : " masaaktif

#bug_addr=${address}.
#bug_addr2=$address
#if [[ $address == "" ]]; then
#sts=$bug_addr2
#else
#sts=$bug_addr
#fi

export exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
export harini=`date -d "0 days" +"%Y-%m-%d"`

sed -i '/#xray-vless-tls$/a\#vls '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/vless.json
sed -i '/#xray-vless-nontls$/a\#vls '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/vlessnone.json

export vlesslink1="vless://${uuid}@${domain}:$tls?path=$patchtls&security=tls&encryption=none&type=ws&sni=$sni#${user}"
export vlesslink2="vless://${uuid}@${domain}:$none?path=$patchnontls&encryption=none&host=$sni&type=ws#${user}"

systemctl restart xray@vless
systemctl restart xray@vlessnone

clear
echo -e ""
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "\e[$back_text      \e[30m[\e[$box XRAY VLESS WS\e[30m ]\e[1m          \e[m"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Remarks          : ${user}"
echo -e "Domain           : ${domain}"
echo -e "IP/Host          : $MYIP"
echo -e "Port TLS         : $tls"
echo -e "Port None TLS    : $none"
echo -e "User ID          : ${uuid}"
echo -e "Encryption       : None"
echo -e "Network          : WebSocket"
echo -e "Path Tls         : $patchtls"
echo -e "Path None Tls    : $patchnontls"
echo -e "allowInsecure    : True/allow"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Pantang Larang $creditt Shop"
echo -e "‼️Aktiviti Berikut Adalah Dilarang(ID akan di ban tanpa notis & tiada refund)"
echo -e "\e[31m❌ Torrent (p2p, streaming p2p)"
echo -e "\e[31m❌ PS4"
echo -e "\e[31m❌ Porn"
echo -e "\e[31m❌ Spam Bug"
echo -e "\e[31m❌ Ddos Server"
echo -e "\e[31m❌ Mining Bitcoins"
echo -e "\e[31m❌ Abuse Usage"
echo -e "\e[31m❌ Multi-Login ID"
echo -e "\e[31m❌ Sharing Premium Config\e[m"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link TLS      : ${vlesslink1}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link None TLS : ${vlesslink2}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Created   : $harini"
echo -e "Expired   : $exp"
echo -e "Script By $creditt"
echo ""
read -n 1 -s -r -p "Press any key to back on menu xray"
xraay
}

# TRIAL USER VLESS WS
function menu8 () {
clear
tls="$(cat ~/log-install.txt | grep -w "Vless Ws Tls" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Vless Ws None Tls" | cut -d: -f2|sed 's/ //g')"
echo -e   "  \e[$line═══════════════════════════════════════════════════════\e[m"
echo -e   "  \e[$back_text           \e[30m[\e[$box TRIAL USER XRAY VLESS WS TLS\e[30m ]\e[1m            \e[m"
echo -e   "  \e[$line═══════════════════════════════════════════════════════\e[m"

# // Create Expried
export masaaktif="1"
export exp=$(date -d "$masaaktif days" +"%Y-%m-%d")

# Make Random Username
export user=Trial`</dev/urandom tr -dc X-Z0-9 | head -c4`

export patchtls=/vless
export patchnontls=/vless
export uuid=$(cat /proc/sys/kernel/random/uuid)

#read -p "   Bug Address (Example: www.google.com) : " address
#read -p "   Bug SNI/Host (Example : m.facebook.com) : " sni

#bug_addr=${address}.
#bug_addr2=$address
#if [[ $address == "" ]]; then
#sts=$bug_addr2
#else
#sts=$bug_addr
#fi

export harini=`date -d "0 days" +"%Y-%m-%d"`

sed -i '/#xray-vless-tls$/a\#vls '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/vless.json
sed -i '/#xray-vless-nontls$/a\#vls '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/vlessnone.json

export vlesslink1="vless://${uuid}@${domain}:$tls?path=$patchtls&security=tls&encryption=none&type=ws&sni=$sni#${user}"
export vlesslink2="vless://${uuid}@$${domain}:$none?path=$patchnontls&encryption=none&host=$sni&type=ws#${user}"

systemctl restart xray@vless
systemctl restart xray@vlessnone

clear
echo -e ""
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "\e[$back_text     \e[30m[\e[$box TRIAL XRAY VLESS WS\e[30m ]\e[1m     \e[m"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Remarks          : ${user}"
echo -e "Domain           : ${domain}"
echo -e "IP/Host          : $MYIP"
echo -e "Port TLS         : $tls"
echo -e "Port None TLS    : $none"
echo -e "User ID          : ${uuid}"
echo -e "Encryption       : None"
echo -e "Network          : WebSocket"
echo -e "Path Tls         : $patchtls"
echo -e "Path None Tls    : $patchnontls"
echo -e "allowInsecure    : True/allow"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Pantang Larang $creditt Shop"
echo -e "‼️Aktiviti Berikut Adalah Dilarang(ID akan di ban tanpa notis & tiada refund)"
echo -e "\e[31m❌ Torrent (p2p, streaming p2p)"
echo -e "\e[31m❌ PS4"
echo -e "\e[31m❌ Porn"
echo -e "\e[31m❌ Spam Bug"
echo -e "\e[31m❌ Ddos Server"
echo -e "\e[31m❌ Mining Bitcoins"
echo -e "\e[31m❌ Abuse Usage"
echo -e "\e[31m❌ Multi-Login ID"
echo -e "\e[31m❌ Sharing Premium Config\e[m"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link TLS      : ${vlesslink1}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link None TLS : ${vlesslink2}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Created   : $harini"
echo -e "Expired   : $exp"
echo -e "Script By $creditt"
echo ""
read -n 1 -s -r -p "Press any key to back on menu xray"
xraay
}

# DELETE USER VLESS WS
function menu9 () {
clear
NUMBER_OF_CLIENTS=$(grep -c -E "^#vls " "/usr/local/etc/xray/vless.json")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		echo ""
		echo "You have no existing clients!"
		exit 1
	fi

	clear
	echo " Delete User Xray Vless Ws"
	echo " Select the existing client you want to remove"
	echo " Press CTRL+C to return"
	echo " ==============================="
	echo "     No  Expired   User"
	grep -E "^#vls " "/usr/local/etc/xray/vless.json" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
export harini=$(grep -E "^#vls " "/usr/local/etc/xray/vless.json" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)
export uuid=$(grep -E "^#vls " "/usr/local/etc/xray/vless.json" | cut -d ' ' -f 5 | sed -n "${CLIENT_NUMBER}"p)
export user=$(grep -E "^#vls " "/usr/local/etc/xray/vless.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
export exp=$(grep -E "^#vls " "/usr/local/etc/xray/vless.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)

sed -i "/^#vls $user $exp $harini $uuid/,/^},{/d" /usr/local/etc/xray/vless.json
sed -i "/^#vls $user $exp $harini $uuid/,/^},{/d" /usr/local/etc/xray/vlessnone.json

systemctl restart xray@vless
systemctl restart xray@vlessnone

clear
echo " Xray Vless Ws Account Deleted Successfully"
echo " =========================="
echo " Client Name : $user"
echo " Expired On  : $exp"
echo " =========================="
echo ""
read -n 1 -s -r -p "Press any key to back on menu xray"
xraay
}

#RENEW VLESS WS
function menu10 () {
clear
NUMBER_OF_CLIENTS=$(grep -c -E "^#vls " "/usr/local/etc/xray/vless.json")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		clear
		echo ""
		echo "You have no existing clients!"
		exit 1
	fi

	clear
	echo "Renew User Xray Vless Ws"
	echo "Select the existing client you want to renew"
	echo " Press CTRL+C to return"
	echo -e "==============================="
	grep -E "^#vls " "/usr/local/etc/xray/vless.json" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
read -p "Expired (days): " masaaktif
export harini=$(grep -E "^#vls " "/usr/local/etc/xray/vless.json" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)
export uuid=$(grep -E "^#vls " "/usr/local/etc/xray/vless.json" | cut -d ' ' -f 5 | sed -n "${CLIENT_NUMBER}"p)
export user=$(grep -E "^#vls " "/usr/local/etc/xray/vless.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
export exp=$(grep -E "^#vls " "/usr/local/etc/xray/vless.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
export now=$(date +%Y-%m-%d)
export d1=$(date -d "$exp" +%s)
export d2=$(date -d "$now" +%s)
export exp2=$(( (d1 - d2) / 86400 ))
export exp3=$(($exp2 + $masaaktif))
export exp4=`date -d "$exp3 days" +"%Y-%m-%d"`

sed -i "s/#vls $user $exp $harini $uuid/#vls $user $exp4 $harini $uuid/g" /usr/local/etc/xray/vless.json
sed -i "s/#vls $user $exp $harini $uuid/#vls $user $exp4 $harini $uuid/g" /usr/local/etc/xray/vlessnone.json

systemctl restart xray@vless
systemctl restart xray@vlessnone
service cron restart

clear
echo ""
echo " VLESS WS Account Was Successfully Renewed"
echo " =========================="
echo " Client Name : $user"
echo " Expired On  : $exp4"
echo " =========================="
echo ""
read -n 1 -s -r -p "Press any key to back on menu xray"
xraay
}

# show user vless ws
function menu11 () {
clear
tls="$(cat ~/log-install.txt | grep -w "Vless Ws Tls" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Vless Ws None Tls" | cut -d: -f2|sed 's/ //g')"
NUMBER_OF_CLIENTS=$(grep -c -E "^#vls " "/usr/local/etc/xray/vless.json")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		clear
		echo ""
		echo "You have no existing clients!"
		exit 1
	fi

	clear
	echo ""
	echo "SHOW USER XRAY VLESS WS"
	echo "Select the existing client you want to renew"
	echo " Press CTRL+C to return"
	echo -e "==============================="
	grep -E "^#vls " "/usr/local/etc/xray/vless.json" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
export patchtls=/vless
export patchnontls=/vless
export user=$(grep -E "^#vls " "/usr/local/etc/xray/vless.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
export harini=$(grep -E "^#vls " "/usr/local/etc/xray/vless.json" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)
export exp=$(grep -E "^#vls " "/usr/local/etc/xray/vless.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
export uuid=$(grep -E "^#vls " "/usr/local/etc/xray/vless.json" | cut -d ' ' -f 5 | sed -n "${CLIENT_NUMBER}"p)

export vlesslink1="vless://${uuid}@${domain}:$tls?path=$patchtls&security=tls&encryption=none&type=ws&sni=$sni#${user}"
export vlesslink2="vless://${uuid}@${domain}:$none?path=$patchnontls&encryption=none&host=$sni&type=ws#${user}"

clear
echo -e ""
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "\e[$back_text      \e[30m[\e[$box XRAY VLESS WS\e[30m ]\e[1m          \e[m"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Remarks          : ${user}"
echo -e "Domain           : ${domain}"
echo -e "IP/Host          : $MYIP"
echo -e "Port TLS         : $tls"
echo -e "Port None TLS    : $none"
echo -e "User ID          : ${uuid}"
echo -e "Encryption       : None"
echo -e "Network          : WebSocket"
echo -e "Path Tls         : $patchtls"
echo -e "Path None Tls    : $patchnontls"
echo -e "allowInsecure    : True/allow"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Pantang Larang $creditt Shop"
echo -e "‼️Aktiviti Berikut Adalah Dilarang(ID akan di ban tanpa notis & tiada refund)"
echo -e "\e[31m❌ Torrent (p2p, streaming p2p)"
echo -e "\e[31m❌ PS4"
echo -e "\e[31m❌ Porn"
echo -e "\e[31m❌ Spam Bug"
echo -e "\e[31m❌ Ddos Server"
echo -e "\e[31m❌ Mining Bitcoins"
echo -e "\e[31m❌ Abuse Usage"
echo -e "\e[31m❌ Multi-Login ID"
echo -e "\e[31m❌ Sharing Premium Config\e[m"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link TLS      : ${vlesslink1}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link None TLS : ${vlesslink2}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Created   : $harini"
echo -e "Expired   : $exp"
echo -e "Script By $creditt"
echo ""
read -n 1 -s -r -p "Press any key to back on menu xray"
xraay
}

# USER LOGIN VLESS WS
function menu12 () {
clear
echo -n > /tmp/other.txt
data=( `cat /usr/local/etc/xray/vless.json | grep '^#vls' | cut -d ' ' -f 2`);
echo -e "\033[0;34m══════════════════════════════════════════\033[0m"
echo -e "\\E[0;44;37m      ⇱ XRAY Vless WS User Login ⇲        \E[0m"
echo -e "\033[0;34m══════════════════════════════════════════\033[0m"
for akun in "${data[@]}"
do
if [[ -z "$akun" ]]; then
akun="tidakada"
fi
echo -n > /tmp/ipvless.txt
data2=( `netstat -anp | grep ESTABLISHED | grep tcp6 | grep xray | awk '{print $5}' | cut -d: -f1 | sort | uniq`);
for ip in "${data2[@]}"
do
jum=$(cat /var/log/xray/access.log | grep -w $akun | awk '{print $3}' | cut -d: -f1 | grep -w $ip | sort | uniq)
if [[ "$jum" = "$ip" ]]; then
echo "$jum" >> /tmp/ipvless.txt
else
echo "$ip" >> /tmp/other.txt
fi
jum2=$(cat /tmp/ipvless.txt)
sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
done
jum=$(cat /tmp/ipvless.txt)
if [[ -z "$jum" ]]; then
echo > /dev/null
else
jum2=$(cat /tmp/ipvless.txt | nl)
echo "user : $akun";
echo "$jum2";
echo ""
echo -e "\e[$line══════════════════════════════════════════\e[m"
fi
rm -rf /tmp/ipvmess.txt
rm -rf /tmp/other.txt
done
echo ""
read -n 1 -s -r -p "Press any key to back on menu xray"
xraay
}

# CREATE USER VLESS XTLS
function menu13 () {
clear
xtls="$(cat ~/log-install.txt | grep -w "Vless Tcp Xtls" | cut -d: -f2|sed 's/ //g')"
echo -e   "  \e[$line═══════════════════════════════════════════════════════\e[m"
echo -e   "  \e[$back_text            \e[30m[\e[$box CREATE USER XRAY VLESS XTLS\e[30m ]\e[1m            \e[m"
echo -e   "  \e[$line═══════════════════════════════════════════════════════\e[m"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "   Username: " -e user
		CLIENT_EXISTS=$(grep -w $user /usr/local/etc/xray/config.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			exit 1
		fi
	done
export uuid=$(cat /proc/sys/kernel/random/uuid)
#read -p "   Bug Address (Example: www.google.com) : " address
#read -p "   Bug SNI/Host (Example : m.facebook.com) : " sni
#read -p "   Expired (days) : " masaaktif

#bug_addr=${address}.
#bug_addr2=$address
#if [[ $address == "" ]]; then
#sts=$bug_addr2
#else
#sts=$bug_addr
#fi

export exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
export harini=`date -d "0 days" +"%Y-%m-%d"`

sed -i '/#xray-vless-xtls$/a\#vxtls '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","flow": "'""xtls-rprx-direct""'","level": '"0"',"email": "'""$user""'"' /usr/local/etc/xray/config.json

export vlesslink1="vless://${uuid}@${domain}:$xtls?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-direct&sni=$sni#${user}"
export vlesslink2="vless://${uuid}@${domain}:$xtls?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-splice&sni=$sni#${user}"

systemctl restart xray.service

clear
echo -e ""
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "\e[$back_text     \e[30m[\e[$box XRAY VLESS XTLS\e[30m ]\e[1m         \e[m"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Remarks        : ${user}"
echo -e "Domain         : ${domain}"
echo -e "Ip/Host        : ${MYIP}"
echo -e "Port Xtls      : $xtls"
echo -e "User ID        : ${uuid}"
echo -e "Encryption     : None"
echo -e "Network        : TCP"
echo -e "Flow           : Direct & Splice"
echo -e "allowInsecure  : True"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Pantang Larang $creditt Shop"
echo -e "‼️Aktiviti Berikut Adalah Dilarang(ID akan di ban tanpa notis & tiada refund)"
echo -e "\e[31m❌ Torrent (p2p, streaming p2p)"
echo -e "\e[31m❌ PS4"
echo -e "\e[31m❌ Porn"
echo -e "\e[31m❌ Spam Bug"
echo -e "\e[31m❌ Ddos Server"
echo -e "\e[31m❌ Mining Bitcoins"
echo -e "\e[31m❌ Abuse Usage"
echo -e "\e[31m❌ Multi-Login ID"
echo -e "\e[31m❌ Sharing Premium Config\e[m"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link Xtls Direct : ${vlesslink1}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link Xtls Splice : ${vlesslink2}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Created  : $harini"
echo -e "Expired  : $exp"
echo -e "Script By $creditt"
echo ""
read -n 1 -s -r -p "Press any key to back on menu xray"
xraay
}

# TRIAL USER VLESS XTLS
function menu14 () {
clear
xtls="$(cat ~/log-install.txt | grep -w "Vless Tcp Xtls" | cut -d: -f2|sed 's/ //g')"
echo -e   "  \e[$line═══════════════════════════════════════════════════════\e[m"
echo -e   "  \e[$back_text            \e[30m[\e[$box TRIAL USER XRAY VLESS XTLS\e[30m ]\e[1m             \e[m"
echo -e   "  \e[$line═══════════════════════════════════════════════════════\e[m"

# // Create Expried
export masaaktif="1"
export exp=$(date -d "$masaaktif days" +"%Y-%m-%d")

# // Make Random Username
export user=Trial`</dev/urandom tr -dc X-Z0-9 | head -c4`
export uuid=$(cat /proc/sys/kernel/random/uuid)

#read -p "   Bug Address (Example: www.google.com) : " address
#read -p "   Bug SNI/Host (Example : m.facebook.com) : " sni

#bug_addr=${address}.
#bug_addr2=$address
#if [[ $address == "" ]]; then
#sts=$bug_addr2
#else
#sts=$bug_addr
#fi

export harini=`date -d "0 days" +"%Y-%m-%d"`

sed -i '/#xray-vless-xtls$/a\#vxtls '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","flow": "'""xtls-rprx-direct""'","level": '"0"',"email": "'""$user""'"' /usr/local/etc/xray/config.json

export vlesslink1="vless://${uuid}@${domain}:$xtls?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-direct&sni=$sni#${user}"
export vlesslink2="vless://${uuid}@${domain}:$xtls?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-splice&sni=$sni#${user}"

systemctl restart xray.service

clear
echo -e ""
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "\e[$back_text    \e[30m[\e[$box TRIAL XRAY VLESS XTLS\e[30m ]\e[1m    \e[m"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Remarks        : ${user}"
echo -e "Domain         : ${domain}"
echo -e "Ip/Host        : ${MYIP}"
echo -e "Port Xtls      : $xtls"
echo -e "User ID        : ${uuid}"
echo -e "Encryption     : None"
echo -e "Network        : TCP"
echo -e "Flow           : Direct & Splice"
echo -e "allowInsecure  : True"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Pantang Larang $creditt Shop"
echo -e "‼️Aktiviti Berikut Adalah Dilarang(ID akan di ban tanpa notis & tiada refund)"
echo -e "\e[31m❌ Torrent (p2p, streaming p2p)"
echo -e "\e[31m❌ PS4"
echo -e "\e[31m❌ Porn"
echo -e "\e[31m❌ Spam Bug"
echo -e "\e[31m❌ Ddos Server"
echo -e "\e[31m❌ Mining Bitcoins"
echo -e "\e[31m❌ Abuse Usage"
echo -e "\e[31m❌ Multi-Login ID"
echo -e "\e[31m❌ Sharing Premium Config\e[m"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link Xtls Direct  : ${vlesslink1}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link Xtls Splice  : ${vlesslink2}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Created  : $harini"
echo -e "Expired  : $exp"
echo -e "Script By $creditt"
echo ""
read -n 1 -s -r -p "Press any key to back on menu xray"
xraay
}

# DELETE VLESS XTLS
function menu15 () {
clear
NUMBER_OF_CLIENTS=$(grep -c -E "^#vxtls " "/usr/local/etc/xray/config.json")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		echo ""
		echo "You have no existing clients!"
		exit 1
	fi

	clear
	echo ""
	echo " Delete User Xray Vless Tcp Xtls"
	echo " Select the existing client you want to remove"
	echo " Press CTRL+C to return"
	echo " ==============================="
	echo "     No  Expired   User"
	grep -E "^#vxtls " "/usr/local/etc/xray/config.json" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
export harini=$(grep -E "^#vxtls " "/usr/local/etc/xray/config.json" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)
export uuid=$(grep -E "^#vxtls " "/usr/local/etc/xray/config.json" | cut -d ' ' -f 5 | sed -n "${CLIENT_NUMBER}"p)
export user=$(grep -E "^#vxtls " "/usr/local/etc/xray/config.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
export exp=$(grep -E "^#vxtls " "/usr/local/etc/xray/config.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)

sed -i "/^#vxtls $user $exp $harini $uuid/,/^},{/d" /usr/local/etc/xray/config.json

systemctl restart xray.service

clear
echo " Xray Vless Tcp Xtls Account Deleted Successfully"
echo " =========================="
echo " Client Name : $user"
echo " Expired On  : $exp"
echo " =========================="
echo ""
read -n 1 -s -r -p "Press any key to back on menu xray"
xraay
}

# RENEW VLESS XTLS
function menu16 () {
clear
NUMBER_OF_CLIENTS=$(grep -c -E "^#vxtls " "/usr/local/etc/xray/config.json")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		clear
		echo ""
		echo "You have no existing clients!"
		exit 1
	fi

	clear
	echo ""
	echo "Renew User Xray Vless Tcp Xtls"
	echo "Select the existing client you want to renew"
	echo " Press CTRL+C to return"
	echo -e "==============================="
	grep -E "^#vxtls " "/usr/local/etc/xray/config.json" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
read -p "Expired (days): " masaaktif
export harini=$(grep -E "^#vxtls " "/usr/local/etc/xray/config.json" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)
export uuid=$(grep -E "^#vxtls " "/usr/local/etc/xray/config.json" | cut -d ' ' -f 5 | sed -n "${CLIENT_NUMBER}"p)
export user=$(grep -E "^#vxtls " "/usr/local/etc/xray/config.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
export exp=$(grep -E "^#vxtls " "/usr/local/etc/xray/config.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
export now=$(date +%Y-%m-%d)
export d1=$(date -d "$exp" +%s)
export d2=$(date -d "$now" +%s)
export exp2=$(( (d1 - d2) / 86400 ))
export exp3=$(($exp2 + $masaaktif))
export exp4=`date -d "$exp3 days" +"%Y-%m-%d"`

sed -i "s/#vxtls $user $exp $harini $uuid/#vxtls $user $exp4 $harini $uuid/g" /usr/local/etc/xray/config.json

systemctl restart xray.service
service cron restart

clear
echo ""
echo " Xray Vless Tcp Xtls Account Was Successfully Renewed"
echo " =========================="
echo " Client Name : $user"
echo " Expired On  : $exp4"
echo " =========================="
echo ""
read -n 1 -s -r -p "Press any key to back on menu xray"
xraay
}

#SHOW VLESS XTLS
function menu17 () {
clear
xtls="$(cat ~/log-install.txt | grep -w "Vless Tcp Xtls" | cut -d: -f2|sed 's/ //g')"
NUMBER_OF_CLIENTS=$(grep -c -E "^#vxtls " "/usr/local/etc/xray/config.json")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		clear
		echo ""
		echo "You have no existing clients!"
		exit 1
	fi

	clear
	echo ""
	echo "SHOW USER XRAY VLESS XTLS"
	echo "Select the existing client you want to renew"
	echo " Press CTRL+C to return"
	echo -e "==============================="
	grep -E "^#vxtls " "/usr/local/etc/xray/config.json" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
export user=$(grep -E "^#vxtls " "/usr/local/etc/xray/config.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
export harini=$(grep -E "^#vxtls " "/usr/local/etc/xray/config.json" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)
export exp=$(grep -E "^#vxtls " "/usr/local/etc/xray/config.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
export uuid=$(grep -E "^#vxtls " "/usr/local/etc/xray/config.json" | cut -d ' ' -f 5 | sed -n "${CLIENT_NUMBER}"p)

export vlesslink1="vless://${uuid}@${domain}:$xtls?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-direct&sni=bug.com#${user}"
export vlesslink2="vless://${uuid}@${domain}:$xtls?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-splice&sni=bug.com#${user}"

clear
echo -e ""
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "\e[$back_text     \e[30m[\e[$box XRAY VLESS XTLS\e[30m ]\e[1m         \e[m"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Remarks          : ${user}"
echo -e "Domain           : ${domain}"
echo -e "Ip/Host          : ${MYIP}"
echo -e "Port Xtls        : $xtls"
echo -e "User ID          : ${uuid}"
echo -e "Encryption       : None"
echo -e "Network          : TCP"
echo -e "Flow             : Direct & Splice"
echo -e "allowInsecure    : True"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Pantang Larang $creditt Shop"
echo -e "‼️Aktiviti Berikut Adalah Dilarang(ID akan di ban tanpa notis & tiada refund)"
echo -e "\e[31m❌ Torrent (p2p, streaming p2p)"
echo -e "\e[31m❌ PS4"
echo -e "\e[31m❌ Porn"
echo -e "\e[31m❌ Spam Bug"
echo -e "\e[31m❌ Ddos Server"
echo -e "\e[31m❌ Mining Bitcoins"
echo -e "\e[31m❌ Abuse Usage"
echo -e "\e[31m❌ Multi-Login ID"
echo -e "\e[31m❌ Sharing Premium Config\e[m"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link Xtls Direct : ${vlesslink1}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Link Xtls Splice : ${vlesslink2}"
echo -e "\e[$line═════════════════════════════════\e[m"
echo -e "Created    : $harini"
echo -e "Expired    : $exp"
echo -e "Script By $creditt"
echo ""
read -n 1 -s -r -p "Press any key to back on menu xray"
xraay
}

# CEK USER LOGIN VLESS XTLS
function menu18 () {
clear
echo -n > /tmp/other.txt
data=( `cat /usr/local/etc/xray/config.json | grep '^#vxtls' | cut -d ' ' -f 2`);
echo -e "\033[0;34m══════════════════════════════════════════\033[0m"
echo -e "\\E[0;44;37m     ⇱ XRAY Vless Xtls User Login ⇲       \E[0m"
echo -e "\033[0;34m══════════════════════════════════════════\033[0m"
for akun in "${data[@]}"
do
if [[ -z "$akun" ]]; then
akun="tidakada"
fi
echo -n > /tmp/ipxray.txt
data2=( `netstat -anp | grep ESTABLISHED | grep tcp6 | grep xray | awk '{print $5}' | cut -d: -f1 | sort | uniq`);
for ip in "${data2[@]}"
do
jum=$(cat /var/log/xray/access.log | grep -w $akun | awk '{print $3}' | cut -d: -f1 | grep -w $ip | sort | uniq)
if [[ "$jum" = "$ip" ]]; then
echo "$jum" >> /tmp/ipxray.txt
else
echo "$ip" >> /tmp/other.txt
fi
jum2=$(cat /tmp/ipxray.txt)
sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
done
jum=$(cat /tmp/ipxray.txt)
if [[ -z "$jum" ]]; then
echo > /dev/null
else
jum2=$(cat /tmp/ipxray.txt | nl)
echo "user : $akun";
echo "$jum2";
echo ""
echo -e "\e[$line══════════════════════════════════════════\e[m"
fi
rm -rf /tmp/ipxray.txt
rm -rf /tmp/other.txt
done
echo ""
read -n 1 -s -r -p "Press any key to back on menu xray"
xraay
}

# MENU XRAY VMESS & VLESS
clear
echo -e ""
echo -e "   \e[$line══════════════════════════════════════════\e[m"
echo -e "   \e[$back_text    \e[30m[\e[$box PANEL XRAY VMESS WEBSOCKET TLS\e[30m ]\e[1m    \e[m"
echo -e "   \e[$line══════════════════════════════════════════\e[m"
echo -e "    \e[$number (•1)\e[m \e[$below Create Vmess Websocket Account\e[m"
echo -e "    \e[$number (•2)\e[m \e[$below Trial User Vmess Websocket\e[m"
echo -e "    \e[$number (•3)\e[m \e[$below Delete Vmess Websocket Account\e[m"
echo -e "    \e[$number (•4)\e[m \e[$below Renew Vmess Websocket Account\e[m"
echo -e "    \e[$number (•5)\e[m \e[$below Show Config Vmess Account\e[m"
echo -e "    \e[$number (•6)\e[m \e[$below Check User Login Vmess\e[m"
echo -e ""
echo -e "   \e[$number    >> Total :\e[m \e[$below ${total1} Client\e[m"
echo -e "   \e[$line══════════════════════════════════════════\e[m"
echo -e "   \e[$back_text    \e[30m[\e[$box PANEL XRAY VLESS WEBSOCKET TLS\e[30m ]\e[1m    \e[m"
echo -e "   \e[$line══════════════════════════════════════════\e[m"
echo -e "    \e[$number (•7)\e[m \e[$below Create Vless Websocket Account\e[m"
echo -e "    \e[$number (•8)\e[m \e[$below Trial User Vless Websocket\e[m"
echo -e "    \e[$number (•9)\e[m \e[$below Deleting Vless Websocket Account\e[m"
echo -e "    \e[$number (10)\e[m \e[$below Renew Vless Websocket Account\e[m"
echo -e "    \e[$number (11)\e[m \e[$below Show Config Vless Account\e[m"
echo -e "    \e[$number (12)\e[m \e[$below Check User Login Vless\e[m"
echo -e ""
echo -e "   \e[$number    >> Total :\e[m \e[$below ${total2} Client\e[m"
echo -e "   \e[$line══════════════════════════════════════════\e[m"
echo -e "   \e[$back_text \e[30m[\e[$box XRAY VLESS TCP XTLS(Direct & Splice)\e[30m ]\e[1m \e[m"
echo -e "   \e[$line══════════════════════════════════════════\e[m"
echo -e "    \e[$number (13)\e[m \e[$below Create Xray VLess Xtls Account\e[m"
echo -e "    \e[$number (14)\e[m \e[$below Trial User Vless Xtls\e[m"
echo -e "    \e[$number (15)\e[m \e[$below Deleting Xray Vless Xtls Account\e[m"
echo -e "    \e[$number (16)\e[m \e[$below Renew Xray Vless Xtls Account\e[m"
echo -e "    \e[$number (17)\e[m \e[$below Show Config Vless Xtls Account\e[m"
echo -e "    \e[$number (18)\e[m \e[$below Check User Login Vless Xtls\e[m"
echo -e ""
echo -e "   \e[$number    >> Total :\e[m \e[$below ${total3} Client\e[m"
echo -e "   \e[$line══════════════════════════════════════════\e[m"
echo -e "   \e[$back_text  \e[$box x)   MENU                              \e[m"
echo -e "   \e[$line══════════════════════════════════════════\e[m"
echo -e "\e[$line"
read -rp "        Please Input Number  [1-18 or x] :  "  num
echo -e ""
if [[ "$num" = "1" ]]; then
menu1
elif [[ "$num" = "2" ]]; then
menu2
elif [[ "$num" = "3" ]]; then
menu3
elif [[ "$num" = "4" ]]; then
menu4
elif [[ "$num" = "5" ]]; then
menu5
elif [[ "$num" = "6" ]]; then
menu6
elif [[ "$num" = "7" ]]; then
menu7
elif [[ "$num" = "8" ]]; then
menu8
elif [[ "$num" = "9" ]]; then
menu9
elif [[ "$num" = "10" ]]; then
menu10
elif [[ "$num" = "11" ]]; then
menu11
elif [[ "$num" = "12" ]]; then
menu12
elif [[ "$num" = "13" ]]; then
menu13
elif [[ "$num" = "14" ]]; then
menu14
elif [[ "$num" = "15" ]]; then
menu15
elif [[ "$num" = "16" ]]; then
menu16
elif [[ "$num" = "17" ]]; then
menu17
elif [[ "$num" = "18" ]]; then
menu18
elif [[ "$num" = "x" ]]; then
menu
else
clear
echo -e "\e[1;31mYou Entered The Wrong Number, Please Try Again!\e[0m"
sleep 1
xraay
fi
