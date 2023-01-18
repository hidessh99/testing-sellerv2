##!/bin/bash
#Rohmaniyah
#nama IP EXP
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
domainku=$(cat /etc/xray/domain)
uuid=$(uuid)
#sec=$(date +%M%S)
MYIP=$(cat /etc/xray/public)
clear
read -p "Silahkan masukan username : " user
read -p "Silahkan masukan masaaktif : " masaaktif
read -p "SIlahkan masukan email pelanggan : " reseler
user2=$(echo "$reseler" | wc -w)
if [[ $user2 -gt 0 ]]; then
echo ""
else
nais123="123"
fi
makanan=$(cat /etc/xray/domain.log | grep $reseler | cut -d " " -f 2)
user1=$(cat /etc/xray/domain.log | grep $reseler -o)
if [[ $user1 == "$reseler$nais123" ]]; then
domain="$makanan"
else
domain="$domainku"
fi
akun=$(cat /etc/xray/vmess-ws.json | grep $user -o | uniq | wc -l)
if [ $akun = 0 ]; then
clear
echo -e "user belum terdaftar (sah)"
else
clear
echo -e "user telah digunakan"
echo -e "silahkan gunakan nama user lain"
exit
fi
now=`date -d "0 days" +"%Y-%m-%d"`
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#xray$/a\#### '"$user$sec $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user$sec""'"' /etc/xray/vmess-ws-none.json
sed -i '/#xray$/a\#### '"$user$sec $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user$sec""'"' /etc/xray/vmess-ws.json
sed -i '/#xray$/a\#### '"$user$sec $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user$sec""'"' /etc/xray/vmess-grpc.json
sed -i '/#xray$/a\#### '"$user$sec $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user$sec""'"' /etc/xray/worryfree.json
sleep 1 && systemctl restart vmess-ws &
sleep 1 && systemctl restart vmess-grpc &
sleep 1 && systemctl restart worryfree &

cat>/etc/xray/vmess-${user}ws-tls.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "443",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/hidessh-vmessws",
      "type": "none",
      "host": "$domain",
      "tls": "tls"
}
EOF
vmess_base641=$( base64 -w 0 <<< $vmess_json1)
ws="vmess://$(base64 -w 0 /etc/xray/vmess-${user}ws-tls.json)"
cat>/etc/xray/vmess-${user}grpc-tls.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "443",
      "id": "${uuid}",
      "aid": "0",
      "net": "grpc",
      "path": "hidessh-vmess-grpc",
      "type": "none",
      "host": "$domain",
      "tls": "tls"
}
EOF
vmess_base641=$( base64 -w 0 <<< $vmess_json1)
grpc="vmess://$(base64 -w 0 /etc/xray/vmess-${user}grpc-tls.json)"
cat>/etc/xray/vmess-$user-none.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "80",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/hidessh-vmessws",
      "type": "none",
      "host": "$domain",
      "tls": "none"
}
EOF
vmess_base641=$( base64 -w 0 <<< $vmess_json1)
none="vmess://$(base64 -w 0 /etc/xray/vmess-$user-none.json)"
cat> /usr/share/nginx/html/$user$sec.conf << END
=======> HOSTS <=======
User     : $user
Domain   : $domain
IP       : $MYIP
Key/Pass : $uuid
Port     : 443
Created  : $now
Expired  : $exp
======> PLUGIN <=======
Websocekt : /hidessh-vmessws
gRPC      : hidessh-vmess-grpc
=======================
Link Vmess Websocket TLS
=> $ws
═══════════════════════
Link Vmess Websocket None TLS
=> $none
═══════════════════════
Link Vmess gRPC TLS
=> $grpc
═══════════════════════
END
#clear
#echo -e "======> INFORMASI ACCOUNT <======="
#echo -e "        ↡↡↡↡↡        ↡↡↡↡↡ "
#echo -e "https://$domain/$user$sec.conf"
#echo -e "        ↟↟↟↟↟        ↟↟↟↟↟ "
#echo -e "=================================="
akun=$(cat /usr/share/nginx/html/$user$sec.conf)
clear
echo -e "${akun}"

