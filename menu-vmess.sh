#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(cat /etc/xray/public)
IZIN=$(curl https://raw.githubusercontent.com/nuralfiya/Autorekonek-Libernet/main/izin.sh | grep -o $MYIP | cut -d ' ' -f 2)
if [ $MYIP = $IZIN ]; then
        clear
        echo -e "${green}Autentikasi SAH${NC}"
else
        clear
        echo -e "${red}Permintaan Ditolak!${NC}";
        echo "Hanya untuk pengguna terdaftar"
        echo "silahkan hubungi admin thunder_tun"
        exit
fi
clear
echo -e "\e[32m════════════════════════════════════════" | lolcat
echo -e "             ═══[Vmess]═══"
echo -e "\e[32m════════════════════════════════════════" | lolcat
echo -e " 1)  Create Vmess Account"
echo -e " 2)  Deleting Vmess Account"
echo -e " 3)  Renew Vmess Account"
echo -e " 4)  Check User Login Vmess"
echo -e ""
echo -e "\e[1;32m══════════════════════════════════════════\e[m"
echo -e " x)   MENU UTAMA"
echo -e "\e[1;32m══════════════════════════════════════════\e[m"
echo -e ""
read -p "     Please Input Number  [1-4 or x] :  "  menu
echo -e ""
case $menu in
1)
add-vmess
;;
2)
del-vmess
;;
3)
renew-vmess
;;
4)
cek-vmess
;;
x)
menu
;;
*)
echo "Please enter an correct number"
sleep 1
menu-vmess
;;
esac

