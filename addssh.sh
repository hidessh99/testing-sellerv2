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

domainku=$(cat /etc/xray/domain)
nsdomain=$(cat /etc/xray/nsdomain)
slkey=$(cat /etc/slowdns/server.pub)
clear
read -p "Username : " Login
read -p "Password : " Pass
read -p "Expired (Days): " masaaktif
read -p "SIlahkan masukan email pelanggan : " reseler
user2=$(echo "$reseler" | wc -w)
if [[ $user2 -gt 0 ]]; then
echo ""
else
nais123="123"
fi
makanan=$(cat /etc/xray/domain.log | grep $reseler | cut -d " " -f 2)
user1=$(cat /etc/xray/domain.log | grep $reseler -o)
if [[ $user1 == "$reseler$nais123" ]]; then
domain="$makanan"
else
domain="$domainku"
fi
IP=$(wget -qO- ipinfo.io/ip);

ovpn="$(netstat -nlpt | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
ovpn2="$(netstat -nlpu | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
clear
useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
expi="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
hariini=`date -d "0 days" +"%Y-%m-%d"`
expi=`date -d "$masaaktif days" +"%Y-%m-%d"`
echo -e ""
echo -e "Informasi Akun SSH"
echo -e "=============================="
echo -e "Username            : $Login"
echo -e "Password            : $Pass"
echo -e "Created             : $hariini"
echo -e "Expired             : $expi"
echo -e "===========HOST-SSH==========="
echo -e "IP/Host             : $IP"
echo -e "Domain SSH          : $domain"
echo -e "Port ssl/https      : 443"
echo -e "Port dropbear/http  : 80"
echo -e "===========SLOWDNS==========="
echo -e "Domain Name System  : 8.8.8.8"
echo -e "Name Server         : $nsdomain"
echo -e "Public Key          : $slkey"
echo -e "=============================="
echo -e "Payload Websocket"
echo -e "=============================="
echo -e "GET wss://bug.com/ HTTP/1.1[crlf]Host: $domain[crlf]Upgrade: websocket[crlf][crlf]"
echo -e "=============================="

