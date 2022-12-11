#!/bin/bash

#wget -q -O /usr/local/bin/add-ssh-user "https://raw.githubusercontent.com/hidessh99/Package-tambahan-Seller/main/add-ssh-user.sh" && chmod +x /usr/local/bin/add-ssh-user

#worry free
wget -q -O /etc/xray/svr-vmess-worry.json "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/xray/svr-vmess-worry.json"

#kouta habis
wget -q -O /etc/xray/kouta-habis.json "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/xray/svr-vmess-habis.json" 
cd
#worry free vmess ws
cat> /etc/systemd/system/vmess-worry.service << END
[Unit]
Description=Vmess Worryfree Service
Documentation=https://github.com/xtls
After=network.target nss-lookup.target

[Service]
User=nobody
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /etc/xray/svr-vmess-worry.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
END
#worry free vmess ws
cat> /etc/systemd/system/vmess-kouta.service << END
[Unit]
Description=Vmess Kouta habis Service
Documentation=https://github.com/xtls
After=network.target nss-lookup.target

[Service]
User=nobody
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /etc/xray/kouta-habis.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
END


#service system
systemctl enable vmess-worry
systemctl restart vmess-worry

systemctl enable vmess-kouta
systemctl restart vmess-kouta
