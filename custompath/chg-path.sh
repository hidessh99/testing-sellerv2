#!/bin/bash
read -p "Enter the path contoh /hidessh-vmess-ws: " -e path
echo $path >> /root/path.txt

PATH1=$(cat /root/path.txt);
PATH2="s/xxxxxxxxx/$PATH1/g";

#Edit CONF VMESS
wget -O /etc/xray/vmess-ws.json "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/custompath/custom-vmess.sh"
sed -i $PATH2 /etc/xray/vmess-ws.json

#add user Vmess
wget -O /usr/local/bin/add-vmess-user "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/custompath/add-vmess5.sh"
