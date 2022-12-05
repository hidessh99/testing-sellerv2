#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(cat /etc/xray/public)
clear
echo -e "\e[32m════════════════════════════════════════" | lolcat
echo -e "             ═══[Shadowsocks]═══"
echo -e "\e[32m════════════════════════════════════════" | lolcat
echo -e " 1)  Create Shadowsocks Account"
echo -e " 2)  Deleting Shadowsocks Account"
echo -e " 3)  Renew Shadowsocks Account"
echo -e " 4)  Check User Login Shadowsocks"
echo -e ""
echo -e "\e[1;32m══════════════════════════════════════════\e[m"
echo -e " x)   MENU UTAMA"
echo -e "\e[1;32m══════════════════════════════════════════\e[m"
echo -e ""
read -p "     Please Input Number  [1-4 or x] :  "  menu
echo -e ""
case $menu in
1)
add-ss
;;
2)
del-ss
;;
3)
renew-ss
;;
4)
cek-ss
;;
x)
menu
;;
*)
echo "Please enter an correct number"
sleep 1
menu-ss
;;
esac

