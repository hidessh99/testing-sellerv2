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

uuid=$(cat /proc/sys/kernel/random/uuid)
masaaktif=365
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#xray$/a\#### '"$user $exp"'\
},{"id": "'""$user""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/vmess-ws.json
sed -i '/#xray$/a\#### '"$user $exp"'\
},{"id": "'""$user""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/vmess-grpc.json
sed -i '/#xray$/a\#### '"$user $exp"'\
},{"id": "'""$user""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/svr-vmess-worry.json
sed -i '/#xray$/a\#### '"$user $exp"'\
},{"id": "'""$user""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/kouta-habis.json
sleep 1 && systemctl restart vmess-ws 
sleep 1 && systemctl restart vmess-grpc 
sleep 1 && systemctl restart vmess-worry 
sleep 1 && systemctl restart vmess-kouta
asu=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "443",
      "id": "${user}",
      "aid": "0",
      "net": "ws",
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
      "id": "${user}",
      "aid": "0",
      "net": "ws",
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
      "id": "${user}",
      "aid": "0",
      "net": "grpc",
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
systemctl restart xray > /dev/null 2>&1
service cron restart > /dev/null 2>&1
clear
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | tee -a /etc/log-create-user.log
echo -e "1     V2Ray/Vmess Account      " | tee -a /etc/log-create-user.log
echo -e "2 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | tee -a /etc/log-create-user.log
echo -e "3 Remarks : ${user}" | tee -a /etc/log-create-user.log
echo -e "4 Domain : ${domain}" | tee -a /etc/log-create-user.log
echo -e "5 Port TLS : ${tls}" | tee -a /etc/log-create-user.log
echo -e "6 Port none TLS : ${none}" | tee -a /etc/log-create-user.log
echo -e "7 Port  GRPC : ${tls}" | tee -a /etc/log-create-user.log
echo -e "8 id : ${user}" | tee -a /etc/log-create-user.log
echo -e "9 alterId : 0" | tee -a /etc/log-create-user.log
echo -e "10 Security : auto" | tee -a /etc/log-create-user.log
echo -e "11 Network : ws" | tee -a /etc/log-create-user.log
echo -e "12 Path : /hidessh-vmessws" | tee -a /etc/log-create-user.log
echo -e "13 ServiceName : hidessh-vmess-grpc" | tee -a /etc/log-create-user.log
echo -e "14 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | tee -a /etc/log-create-user.log
echo -e "15 Link TLS : ${vmesslink1}" | tee -a /etc/log-create-user.log
echo -e "16 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | tee -a /etc/log-create-user.log
echo -e "17 Link non-TLS : ${vmesslink2}" | tee -a /etc/log-create-user.log
echo -e "18 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | tee -a /etc/log-create-user.log
echo -e "19 Link GRPC : ${vmesslink3}" | tee -a /etc/log-create-user.log
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | tee -a /etc/log-create-user.log
echo "" | tee -a /etc/log-create-user.log
echo -e "Path Custom: /worryfree" | tee -a /etc/log-create-user.log
echo -e "Path Custom: /kuota-habis" | tee -a /etc/log-create-user.log