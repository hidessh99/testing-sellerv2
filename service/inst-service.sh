#!/bin/bash
cd
wget -q -O /etc/systemd/system/trojan-tcp.service "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/service/trojan-tcp.service"
wget -q -O /etc/systemd/system/ntls.service "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/service/ntls.service"
#systemctl vless
wget -q -O /etc/systemd/system/vless-ws.service "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/service/vless-ws.service"
wget -q -O /etc/systemd/system/vless-grpc.service "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/service/vless-grpc.service"
#systemctl vmess
wget -q -O /etc/systemd/system/vmess-ws.service "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/service/vmess-ws.service"
wget -q -O /etc/systemd/system/vmess-grpc.service "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/service/vmess-grpc.service"
#systemctl trojan
wget -q -O /etc/systemd/system/trojan-ws.service "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/service/trojan-ws.service"
wget -q -O /etc/systemd/system/trojan-grpc.service "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/service/trojan-grpc.service"

#permission service
chmod +x /etc/systemd/system/trojan-tcp.service
chmod +x /etc/systemd/system/ntls.service
chmod +x /etc/systemd/system/vless-ws.service
chmod +x /etc/systemd/system/vless-grpc.service
chmod +x /etc/systemd/system/vmess-ws.service
chmod +x /etc/systemd/system/vmess-grpc.service
chmod +x /etc/systemd/system/trojan-ws.service
chmod +x /etc/systemd/system/trojan-grpc.service

systemctl enable trojan-tcp
systemctl enable trojan-ws
systemctl enable trojan-grpc
systemctl enable vless-ws
systemctl enable vless-grpc
systemctl enable vmess-ws
systemctl enable vmess-grpc
systemctl enable ntls
systemctl enable nginx
systemctl disable xray

#deleted file
rm -rf /root/inst-service.sh