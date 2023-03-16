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
echo "This Feature Can Only Be Used According To Vps Data With This Autoscript"
echo "Please input link to your vps data backup file."
echo "You can check it on your email if you run backup data vps before."
read -rp "Link File: " -e url
wget -O backup.zip "$url"
unzip backup.zip
rm -f backup.zip
sleep 1
echo Start Restore
cd /root/backup
cp /etc/passwd backup/
cp /etc/group backup/
cp /etc/shadow backup/
cp /etc/gshadow backup/
cp /etc/msmtprc backup/
cp /home/email backup/
#cp /etc/ppp/chap-secrets backup/chap-secrets
cp -r /var/lib/ backup
cp -r /usr/local/etc/xray backup/xray
#cp -r /etc/xray backup/xray
cp -r /home/vps backup/vps
#cp -r /home/vps/public_html backup/public_html

systemctl restart xray
rm -rf /root/backup
rm -f backup.zip
echo Done
