#!/bin/bash
#Nur_Alfiyaku
#em0zz
#IndoSSH
rm /var/log/xray/*
systemctl restart nginx
#systemctl restart trojan-tcp
systemctl restart trojan-ws
systemctl restart trojan-grpc
systemctl restart vmess-grpc
systemctl restart vmess-ws
systemctl restart vless-ws
systemctl restart vless-grpc
systemctl restart vmess-ws-none