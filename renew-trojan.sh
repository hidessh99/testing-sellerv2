#!/bin/bash
NUMBER_OF_CLIENTS=$(grep -c -E "^#### " "/etc/xray/trojan-ws.json")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		clear
		echo ""
		echo "kmau tidak punya user di service ini!"
		exit 1
	fi

	clear
	echo ""
	echo "silahkan masukan nomor urut user"
	echo -e "==============================="
	grep -E "^#### " "/etc/xray/trojan-ws.json" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
read -p "sikahkan masukan masa aktif : " masaaktif
user=$(grep -E "^#### " "/etc/xray/trojan-ws.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^#### " "/etc/xray/trojan-ws.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
now=$(date +%Y-%m-%d)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
exp3=$(($exp2 + $masaaktif))
exp4=`date -d "$exp3 days" +"%Y-%m-%d"`
sed -i "s/#### $user $exp/#### $user $exp4/g" /etc/xray/trojan-ws.json
sed -i "s/#### $user $exp/#### $user $exp4/g" /etc/xray/trojan-tcp.json
sed -i "s/#### $user $exp/#### $user $exp4/g" /etc/xray/trojan-grpc.json
clear
echo ""
echo " Akun Trojan berhasil diperpanjang"
echo " =========================="
echo " Service     : Trojan"
echo " Client Name : $user"
echo " Expired On  : $exp4"
echo " =========================="
echo " Terimakasih Tuan $user"
