#!/bin/bash
read -p "silajkan masukan username : " user
read -p "sikahkan masukan masa aktif : " masaaktif
eemail=$(echo -e "$user" | wc -w)
if [ $eemail -gt 0 ]; then
echo -e ""
else
echo -e "Maaf Masukan username yang benar!"
exit
fi
akun=$(cat /etc/xray/trojan-ws.json | grep $user | cut -d ' ' -f 2)
if [ $akun = $user ]; then
echo -e ""
else
echo -e "Maaf Tuan Username yang anda masukan tidak Valid"
exit
fi
exp=$(grep -E "^#### " "/etc/xray/vmess-ws.json" | grep $user | cut -d ' ' -f 3)
now=$(date +%Y-%m-%d)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
exp3=$(($exp2 + $masaaktif))
exp4=`date -d "$exp3 days" +"%Y-%m-%d"`
sed -i "s/#### $user $exp/#### $user $exp4/g" /etc/xray/vmess-ws.json
sed -i "s/#### $user $exp/#### $user $exp4/g" /etc/xray/vmess-grpc.json
sed -i "s/#### $user $exp/#### $user $exp4/g" /etc/xray/vmess-ws-none.json
clear
echo ""
echo " Akun Vmess berhasil diperpanjang"
echo " =========================="
echo " Service     : Vmess"
echo " Client Name : $user"
echo " Expired On  : $exp4"
echo " =========================="
echo " Terimakasih Tuan $user"
