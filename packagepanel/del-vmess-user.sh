#!/bin/bash
read -p "User: " -e user
exp=$(grep -wE "^### $user" "/etc/xray/vmess-ws.json" | cut -d ' ' -f 3 | sort | uniq)

sed -i "/^#### $user $exp/,/^},{/d" /etc/xray/vmess-ws.json
sed -i "/^#### $user $exp/,/^},{/d" /etc/xray/vmess-grpc.json
sed -i "/^#### $user $exp/,/^},{/d" /etc/xray/svr-vmess-worry.json
sed -i "/^#### $user $exp/,/^},{/d" /etc/xray/kouta-habis.json

#systemctl restart trojan-tcp
systemctl restart vmess-grpc > /dev/null 2>&1
systemctl restart vmess-ws > /dev/null 2>&1
systemctl restart ntls > /dev/null 2>&1
systemctl restart vmess-worry > /dev/null 2>&1
systemctl restart vmess-kouta > /dev/null 2>&1

clear
