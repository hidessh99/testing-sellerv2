#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
#########################

MYIP=$(curl -sS ipv4.icanhazip.com)
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }

#source /var/lib/scrz-prem/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP
fi

tls=443
none=80
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do

                read -rp "User: " -e user
                CLIENT_EXISTS=$(grep -w $user /etc/xray/vmess-ws.json | wc -l)

                if [[ ${CLIENT_EXISTS} -gt "0" ]]; then
clear
                        echo ""
                        echo "A client with the specified name was already created, please choose another name."
                        echo ""

                        exit 0;
                fi
        done


read -p "Bug Host/SNI : " sni
read -p "Password (UUID) : " uuid
read -p "Expired (Ex. 1 days): " masaaktif
exp=`date -d "$masaaktif" +"%Y-%m-%d"`

sed -i '/#xray$/a\#### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/vmess-ws.json
sed -i '/#xray$/a\#### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/vmess-grpc.json
sleep 2 && systemctl restart vmess-ws &
sleep 2 && systemctl restart vmess-grpc &
asu=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "443",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "sni": "${sni}",
      "path": "/hidessh-vmessws",
      "type": "none",
      "host": "${domain}",
      "tls": "tls"
}
EOF`
ask=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "80",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "sni": "${sni}",
      "path": "/hidessh-vmessws",
      "type": "none",
      "host": "${domain}",
      "tls": "none"
}
EOF`
grpc=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "443",
      "id": "${uuid}",
      "aid": "0",
      "net": "grpc",
      "sni": "${sni}",
      "path": "hidessh-vmess-grpc",
      "type": "none",
      "host": "${domain}",
      "tls": "tls"
}
EOF`
vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmess_base642=$( base64 -w 0 <<< $vmess_json2)
vmess_base643=$( base64 -w 0 <<< $vmess_json3)
vmesslink1="vmess://$(echo $asu | base64 -w 0)"
vmesslink2="vmess://$(echo $ask | base64 -w 0)"
vmesslink3="vmess://$(echo $grpc | base64 -w 0)"
result="{\"tls\":\"$vmesslink1\",\"ntls\":\"$vmesslink2\",\"grpc\":\"$vmesslink3\"}"
resultb64=$( base64 -w 0 <<< $result)

service cron restart > /dev/null 2>&1
clear
echo $resultb64
rm /etc/xray/$user-tls.json > /dev/null 2>&1
rm /etc/xray/$user-none.json > /dev/null 2>&1