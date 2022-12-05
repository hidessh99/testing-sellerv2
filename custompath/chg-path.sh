#!/bin/bash
read -p "Enter the path contoh /hidessh-vmess-ws: " -e path
echo $path >> /root/path.txt

path1=$(cat /root/path.txt)
path2="s/hhhhhhh/$path1/g";



#Edit CONF VMESS
wget -O /etc/xray/vmess-ws.json "https://raw.githubusercontent.com/4hidessh/hidessh/main/xray/vmess-ws.json"
sed -i $path2 /etc/xray/vmess-ws.json


#add user Vmess
wget -O /etc/xray/add-vmess.sh "https://raw.githubusercontent.com/4hidessh/hidessh/main/xray/add-vmess.sh"
