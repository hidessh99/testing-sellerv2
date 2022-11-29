#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
#########################
MYIP=$(curl -sS ipv4.icanhazip.com)

clear
#source /var/lib/scrz-prem/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP
fi
tr=443
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${user_EXISTS} == '0' ]]; do
		read -rp "User: " -e user
		user_EXISTS=$(grep -w $user /etc/xray/trojan-ws.json | wc -l)
		if [ ${user_EXISTS} -gt '1' ]; then
		clear
			echo "A client with the specified name was already created, please choose another name."
			exit 1
		fi
	done

read -p "Password (UUID): " uuid

if [[ "$uuid" == "" ]]; then
 echo "Password is required!"
 exit 1
fi


masaaktif=999
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#xray$/a\#### '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /etc/xray/trojan-tcp.json
sed -i '/#xray$/a\#### '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /etc/xray/trojan-ws.json
sed -i '/#xray$/a\#### '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /etc/xray/trojan-grpc.json

gfw="trojan://${uuid}@${domain}:443"
trojanlink1="trojan://${uuid}@${domain}:${tr}?mode=gun&security=tls&type=grpc&serviceName=hidessh-trojan-grpc&sni=${domain}#${user}"
trojanlink="trojan://${uuid}@${domain}:${tr}?path=%2Fhidessh-trojanws&security=tls&host=${domain}&type=ws&sni=${domain}#${user}"
clear

systemctl restart trojan-ws
systemctl restart trojan-tcp 
systemctl restart trojan-grpc 

echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | tee -a /etc/log-create-user.log
echo -e "       UUID TROJAN ACCOUNT         " | tee -a /etc/log-create-user.log
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | tee -a /etc/log-create-user.log
echo -e "Remarks : ${user}" | tee -a /etc/log-create-user.log
echo -e "Host/IP : ${domain}" | tee -a /etc/log-create-user.log
echo -e "port : ${tr}" | tee -a /etc/log-create-user.log
echo -e "Key : ${uuid}" | tee -a /etc/log-create-user.log
echo -e "Path : /hidessh-trojanws" | tee -a /etc/log-create-user.log
echo -e "ServiceName : hidessh-trojan-grpc" | tee -a /etc/log-create-user.log
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | tee -a /etc/log-create-user.log
echo -e "Link WS : ${trojanlink}" | tee -a /etc/log-create-user.log
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | tee -a /etc/log-create-user.log
echo -e "Link GRPC : ${trojanlink1}" | tee -a /etc/log-create-user.log
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | tee -a /etc/log-create-user.log
echo "" | tee -a /etc/log-create-user.log