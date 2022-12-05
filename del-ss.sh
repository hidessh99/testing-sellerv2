#!/bin/bash
NUMBER_OF_CLIENTS=$(grep -c -E "^#### " "/etc/xray/ss-ws.json")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		echo ""
		echo "Anda tidak mempunyai pelanggan di service ini!"
		exit 1
	fi

	clear
	echo ""
	echo " silahkan masukan nomor urutt client yang akan di hapus"
	echo " Press CTRL+C to return"
	echo " ==============================="
	echo "     No  Expired   User"
	grep -E "^#### " "/etc/xray/ss-ws.json" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
user=$(grep -E "^#### " "/etc/xray/ss-ws.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^#### " "/etc/xray/ss-ws.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
sed -i "/^#### $user $exp/,/^},{/d" /etc/xray/ss-ws.json
sed -i "/^#### $user $exp/,/^},{/d" /etc/xray/ss-gprc.json

#systemctl restart trojan-tcp
systemctl restart ss-grpc
systemctl restart ss-ws

clear
echo " Vmess Akun berhasil dihapus"
echo " =========================="
echo " Servive     : Vmess"
echo " Client Name : $user"
echo " Expired On  : $exp"
echo " =========================="