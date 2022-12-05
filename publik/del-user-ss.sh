#!/bin/bash

##----- Auto Remove Vmess & Shadowsocks
data=( `cat /etc/xray/config.json | grep '^###' | cut -d ' ' -f 2 | sort | uniq`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
#echo $user
exp=$(grep -w "^### $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" -le "0" ]]; then
sed -i "/^### $user $exp/,/^},{/d" //etc/xray/ss-ws.json
sed -i "/^### $user $exp/,/^},{/d" /etc/xray/ss-gprc.json
rm -f /etc/xray/$user-tls.json /etc/xray/$user-none.json
fi
done

#systemctl restart trojan-tcp
systemctl restart ss-grpc
systemctl restart ss-ws