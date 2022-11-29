#!/bin/bash
read -p "User: " -e user
exp=$(grep -E "^#### $user" "/etc/xray/trojan-ws.json" | cut -d ' ' -f 3 | sort | uniq)
sed -i "/^#### $user $exp/,/^},{/d" /etc/xray/trojan-tcp.json
sed -i "/^#### $user $exp/,/^},{/d" /etc/xray/trojan-ws.json
sed -i "/^#### $user $exp/,/^},{/d" /etc/xray/trojan-grpc.json
systemctl restart trojan-tcp
systemctl restart trojan-grpc
systemctl restart trojan-ws
clear