#!/bin/bash
NUMBER_OF_CLIENTS=$(grep -c -E "^#### " "/etc/xray/trojan-ws.json")
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
	grep -E "^#### " "/etc/xray/trojan-ws.json" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
user=$(grep -E "^#### " "/etc/xray/trojan-ws.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^#### " "/etc/xray/trojan-ws.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
sed -i "/^#### $user $exp/,/^},{/d" /etc/xray/trojan-tcp.json
sed -i "/^#### $user $exp/,/^},{/d" /etc/xray/trojan-ws.json
sed -i "/^#### $user $exp/,/^},{/d" /etc/xray/trojan-grpc.json
systemctl restart trojan-tcp
systemctl restart trojan-grpc
systemctl restart trojan-ws
clear
echo " Trojan Akun berhasil dihapus"
echo " =========================="
echo " Service     : Trojan"
echo " Client Name : $user"
echo " Expired On  : $exp"
echo " =========================="