#!/bin/bash

#wget -q -O /usr/local/bin/add-ssh-user "https://raw.githubusercontent.com/hidessh99/Package-tambahan-Seller/main/add-ssh-user.sh" && chmod +x /usr/local/bin/add-ssh-user

#worry free
wget -q -O /etc/xray/svr-vmess-worry.json "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/xray/svr-vmess-worry.json"
wget -q -O /etc/xray/svr-trojan-worry.json "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/xray/svr-trojan-worry.json"


#kouta habis
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
#service worry free
#worry free trojan ws
cat> /etc/systemd/system/trojan-worry.service << END
[Unit]
Description=Vmess Worryfree Service
Documentation=https://github.com/xtls
After=network.target nss-lookup.target

[Service]
User=nobody
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /etc/xray/svr-trojan-worry.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
END

#service system
systemctl enable vmess-worry
systemctl enable trojan-worry

systemctl restart vmess-worry
systemctl restart trojan-worry
