#!/bin/bash
#Nur_Alfiyaku
#em0zz
GREEN='\033[0;32m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'
yl='\e[32;1m'
bl='\e[36;1m'
gl='\e[32;1m'
rd='\e[31;1m'
mg='\e[0;95m'
blu='\e[34m'
op='\e[35m'
or='\033[1;33m'
bd='\e[1m'
color1='\e[031;1m'
color2='\e[34;1m'
color3='\e[0m'
# CHEK STATUS
trojan_tcp_status=$(systemctl status trojan-tcp | grep running -o)
trojan_ws_status=$(systemctl status trojan-ws | grep running -o)
trojan_grpc_status=$(systemctl status trojan-grpc | grep running -o)
vless_ws_status=$(systemctl status vless-ws | grep running -o)
vless_grpc_status=$(systemctl status vless-grpc | grep running -o)
vmess_ws_status=$(systemctl status vmess-ws | grep running -o)
vmess_grpc_status=$(systemctl status vmess-grpc | grep running -o)
nginx_status=$(systemctl status nginx | grep running -o)
# COLOR VALIDATION
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
clear
# STATUS SERVICE WEBSOCKET OPEN OVPN
if [[ $vless_ws_status == "running" ]]; then
   swsovpn=" ${GREEN}Running ${NC}( No Error )${NC}"
else
   swsovpn="${RED}  Not Running ${NC}  ( Error )${NC}"
fi
# STATUS SERVICE WEBSOCKET OPEN OVPN
if [[ $vless_grpc_status == "running" ]]; then
   swsovpn1=" ${GREEN}Running ${NC}( No Error )${NC}"
else
   swsovpn1="${RED}  Not Running ${NC}  ( Error )${NC}"
fi
# STATUS SERVICE SSLH / SSH
if [[ $trojan_ws_status == "running" ]]; then
   sosslh=" ${GREEN}Running ${NC}( No Error )${NC}"
else
   sosslh="${RED}  Not Running ${NC}  ( Error )${NC}"
fi
# STATUS OHP DROPBEAR
if [[ $trojan_grpc_status == "running" ]]; then
   sosslh1=" ${GREEN}Running ${NC}( No Error )${NC}"
else
   sosslh1="${RED}  Not Running ${NC}  ( Error )${NC}"
fi
# STATUS OHP DROPBEAR
if [[ $trojan_tcp_status == "running" ]]; then
   sosslh2=" ${GREEN}Running ${NC}( No Error )${NC}"
else
   sosslh2="${RED}  Not Running ${NC}  ( Error )${NC}"
fi
# STATUS OHP OpenVPN
if [[ $vmess_ws_status == "running" ]]; then
   sohq=" ${GREEN}Running ${NC}( No Error )${NC}"
else
   sohq="${RED}  Not Running ${NC}  ( Error )${NC}"
fi
# STATUS OHP SSH
if [[ $nginx_status == "running" ]]; then
   sohr=" ${GREEN}Running ${NC}( No Error )${NC}"
else
   sohr="${RED}  Not Running ${NC}  ( Error )${NC}"
fi
# STATUS SERVICE WEBSOCKET OPENSSH
if [[ $vmess_grpc_status == "running" ]]; then
   swsopen=" ${GREEN}Running ${NC}( No Error )${NC}"
else
   swsopen="${RED}  Not Running ${NC}  ( Error )${NC}"
fi
domain=$(cat /etc/xray/domain)
echo -e "\E[44;1;39m                $domain           \E[0m"
echo -e "${CYAN}==========================================\033[0m${NC}"
echo -e " * VLESS WS        :$swsovpn"
echo -e " * VLESS GRPC      :$swsovpn1"
echo -e " * TROJAN WS       :$sosslh"
echo -e " * TROJAN GRRPC    :$sosslh1"
echo -e " * TROJAN TCP      :$sosslh2"
echo -e " * VMESS WS        :$sohq"
echo -e " * VMESS GRPC      :$swsopen"
echo -e " * NGINX           :$sohr"
echo -e "${CYAN}==========================================\033[0m${NC}"
