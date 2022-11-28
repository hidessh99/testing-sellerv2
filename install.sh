#!/bin/bash
read -p "Silahkan Masukan domain member anda : " domain
read -p "Silahkan Masukan NSdomain slowdns : " nsdomain
read -p "Silahkan Masukan Lapak anda : " author
#update paket
apt update -y
apt upgrade -y
apt install iptables sudo net-tools neofetch socat curl wget htop vnstat uuid screen -y
apt-get install build-essential zlib1g-dev libpcre3 libpcre3-dev unzip -y
apt-get install libcurl4-openssl-dev libssl-dev libjansson-dev automake autotools-dev build-essential gcc make cmake -y
apt install iptables iptables-persistent -y
apt install curl socat xz-utils wget apt-transport-https gnupg gnupg2 gnupg1 dnsutils lsb-release -y 
apt install socat cron bash-completion ntpdate -y
ipku=$(curl ipinfo.io/ip) 
date
#iptables
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 80 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 443 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 443 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload
#mkdir folder
mkdir /etc/xray
mkdir /etc/nur
#send
echo $domain >> /etc/xray/domain
echo $nsdomain >> /etc/xray/nsdomain
echo $ipku >> /etc/xray/public
echo $resdomain >> /etc/xray/resdomain
echo $author >> /etc/nur/author
#SLOWDNS
apt update -y
apt install -y python3 python3-dnslib net-tools
apt install ncurses-utils -y
apt install dnsutils -y
apt install golang -y
apt install git -y
apt install curl -y
apt install wget -y
apt install ncurses-utils -y
apt install screen -y
apt install cron -y
apt install iptables -y
apt install -y git screen whois dropbear wget
apt install -y pwgen python php jq curl
apt install -y sudo gnutls-bin
apt install -y mlocate dh-make libaudit-dev build-essential
apt install -y dos2unix debconf-utils
service cron reload
apt install python ruby -y
gem install lolcat
service cron restart
#sl-fix
cd /usr/bin
wget -O sl-fix "https://raw.githubusercontent.com/fisabiliyusri/Mantap/main/sslh-fix/sl-fix"
chmod +x sl-fix
sl-fix
cd
sed -i 's/#AllowTcpForwarding yes/AllowTcpForwarding yes/g' /etc/ssh/sshd_config
sed -i 's/Port 22/#Port 22/g' /etc/ssh/sshd_config
echo "Port 2222" >> /etc/ssh/sshd_config
echo "Port 22" >> /etc/ssh/sshd_config
rm -rf /etc/slowdns
mkdir -m 777 /etc/slowdns
wget -q -O /etc/slowdns/server.key "https://raw.githubusercontent.com/fisabiliyusri/SLDNS/main/slowdns/server.key"
wget -q -O /etc/slowdns/server.pub "https://raw.githubusercontent.com/fisabiliyusri/SLDNS/main/slowdns/server.pub"
wget -q -O /etc/slowdns/sldns-server "https://raw.githubusercontent.com/fisabiliyusri/SLDNS/main/slowdns/sldns-server"
wget -q -O /etc/slowdns/sldns-client "https://raw.githubusercontent.com/fisabiliyusri/SLDNS/main/slowdns/sldns-client"
cd
chmod +x /etc/slowdns/server.key
chmod +x /etc/slowdns/server.pub
chmod +x /etc/slowdns/sldns-server
chmod +x /etc/slowdns/sldns-client
cd
#wget -q -O /etc/systemd/system/client-sldns.service "https://raw.githubusercontent.com/fisabiliyusri/SLDNS/main/slowdns/client-sldns.service"
#wget -q -O /etc/systemd/system/server-sldns.service "https://raw.githubusercontent.com/fisabiliyusri/SLDNS/main/slowdns/server-sldns.service"
cd
#install client-sldns.service
cat > /etc/systemd/system/client-sldns.service << END
[Unit]
Description=Client SlowDNS By FunnyVPN
Documentation=https://nekopoi.care
After=network.target nss-lookup.target
[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/etc/slowdns/sldns-client -udp 8.8.8.8:53 --pubkey-file /etc/slowdns/server.pub $nsdomain 127.0.0.1:3369
Restart=on-failure
[Install]
WantedBy=multi-user.target
END
cd
#install server-sldns.service
cat > /etc/systemd/system/server-sldns.service << END
[Unit]
Description=Server SlowDNS By FunnyVPN
Documentation=https://nekopoi.care
After=network.target nss-lookup.target
[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/etc/slowdns/sldns-server -udp :5300 -privkey-file /etc/slowdns/server.key $nsdomain 127.0.0.1:2222
Restart=on-failure
[Install]
WantedBy=multi-user.target
END
cd
chmod +x /etc/systemd/system/client-sldns.service
chmod +x /etc/systemd/system/server-sldns.service
pkill sldns-server
pkill sldns-client
systemctl daemon-reload
systemctl stop client-sldns
systemctl stop server-sldns
systemctl enable client-sldns
systemctl enable server-sldns
systemctl start client-sldns
systemctl start server-sldns
systemctl restart client-sldns
systemctl restart server-sldns
cd
#END
#INSTALL SSH
apt install dropbear
rm /etc/default/dropbear
rm /etc/issue.net
cat >  /etc/default/dropbear <<END
# disabled because OpenSSH is installed
# change to NO_START=0 to enable Dropbear
NO_START=0
# the TCP port that Dropbear listens on
DROPBEAR_PORT=143

# any additional arguments for Dropbear
DROPBEAR_EXTRA_ARGS="-p 109 -p 69 "

# specify an optional banner file containing a message to be
# sent to clients before they connect, such as "/etc/issue.net"
DROPBEAR_BANNER="/etc/issue.net"

# RSA hostkey file (default: /etc/dropbear/dropbear_rsa_host_key)
#DROPBEAR_RSAKEY="/etc/dropbear/dropbear_rsa_host_key"

# DSS hostkey file (default: /etc/dropbear/dropbear_dss_host_key)
#DROPBEAR_DSSKEY="/etc/dropbear/dropbear_dss_host_key"

# ECDSA hostkey file (default: /etc/dropbear/dropbear_ecdsa_host_key)
#DROPBEAR_ECDSAKEY="/etc/dropbear/dropbear_ecdsa_host_key"

# Receive window size - this is a tradeoff between memory and
# network performance
DROPBEAR_RECEIVE_WINDOW=65536
END
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
/etc/init.d/dropbear restart
cat> /etc/issue.net <<END
<br>
<font color="blue"><b>===============================</br></font><br>
<font color="red"><b>********  Funny VPN  ********</b></font><br>
<font color="blue"><b>===============================</br></font><br>
END
#ws-stunnel
cp ws-stunnel /usr/local/bin/ws-stunnel
# install badvpn
cd
wget -O /usr/bin/badvpn-udpgw "https://raw.githubusercontent.com/fisabiliyusri/Mantap/main/ssh/badvpn-udpgw64"
chmod +x /usr/bin/badvpn-udpgw
sed -i '$ i\sleep 30' /etc/rc.local
sed -i '$ i\screen -dmS stunnel python /usr/local/bin/ws-stunnel' /etc/rc.local
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500
cp addssh.sh /usr/bin/addssh
cp delssh.sh /usr/bin/delssh
cp cekssh.sh /usr/bin/cekssh
cp renewssh.sh /usr/bin/renewssh
cp delexp.sh /usr/bin/delexp
cd /usr/bin
chmod +x addssh
chmod +x delssh
chmod +x cekssh
chmod +x renewssh
chmod +x delexp
cd
#END
#install nginx
sudo apt install gnupg2 ca-certificates lsb-release -y
fiyaku=$(lsb_release -a | sed -n 1p | cut -f 2 | tr A-Z a-z) 
echo "deb http://nginx.org/packages/mainline/$fiyaku $(lsb_release -cs) nginx" | sudo tee /etc/apt/sources.list.d/nginx.list
echo -e "Package: *\nPin: origin nginx.org\nPin: release o=nginx\nPin-Priority: 900\n" | sudo tee /etc/apt/preferences.d/99nginx
curl -o /tmp/nginx_signing.key https://nginx.org/keys/nginx_signing.key
# gpg --dry-run --quiet --import --import-options import-show /tmp/nginx_signing.key
sudo mv /tmp/nginx_signing.key /etc/apt/trusted.gpg.d/nginx_signing.asc
sudo apt update
apt install nginx -y
rm /etc/nginx/conf.d/*.conf
rm /etc/nginx/nginx.conf
cd /etc/nginx
wget https://raw.githubusercontent.com/nuralfiya/Autorekonek-Libernet/main/nginx.conf
cd
cat> /etc/nginx/conf.d/funnvpn.conf << END
server {
        listen 81;
        listen [::]:81;
        server_name $domain;
        # shellcheck disable=SC2154
        return 301 https://$domain;
}
server {
                listen 127.0.0.1:31300;
                server_name _;
                return 403;
}
server {
        listen 127.0.0.1:31302 http2;
        server_name $domain;
        root /usr/share/nginx/html;
        location /s/ {
                add_header Content-Type text/plain;
                alias /etc/v2ray-agent/subscribe/;
       }
        location /vless-grpc {
                client_max_body_size 0;
#               keepalive_time 1071906480m;
                keepalive_requests 4294967296;
                client_body_timeout 1071906480m;
                send_timeout 1071906480m;
                lingering_close always;
                grpc_read_timeout 1071906480m;
                grpc_send_timeout 1071906480m;
                grpc_pass grpc://127.0.0.1:31301;
        }
        location /hidessh-trojan-grpc {
                client_max_body_size 0;
#                # keepalive_time 1071906480m;
                keepalive_requests 4294967296;
                client_body_timeout 1071906480m;
                send_timeout 1071906480m;
                lingering_close always;
                grpc_read_timeout 1071906480m;
                grpc_send_timeout 1071906480m;
                grpc_pass grpc://127.0.0.1:31304;
        }
        location /hidessh-vmess-grpc {
                client_max_body_size 0;
                # keepalive_time 1071906480m;
                keepalive_requests 4294967296;
                client_body_timeout 1071906480m;
                send_timeout 1071906480m;
                lingering_close always;
                grpc_read_timeout 1071906480m;
                grpc_send_timeout 1071906480m;
                grpc_pass grpc://127.0.0.1:31303;
        }
}
server {
        listen 127.0.0.1:31300;
        server_name $domain;
        root /usr/share/nginx/html;
        location /s/ {
                add_header Content-Type text/plain;
                alias /etc/v2ray-agent/subscribe/;
        }
        location / {
                add_header Strict-Transport-Security "max-age=15552000; preload" always;
        }
}
END
syatemctl restart nginx
#BBR
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sysctl -p
#install xray
wget https://github.com/XTLS/Xray-install/raw/main/install-release.sh
bash install-release.sh install
#create jaon
cat> /etc/xray/trojan-tcp.json << END
{
  "log": {
      "access": "/var/log/xray/trojan.log",
      "loglevel": "info"
  },
  "inbounds": [
    {
      "port": 443,
      "protocol": "trojan",
      "tag": "TROJANTCP",
      "settings": {
        "clients": [
          {
            "password": "eef46d87-ae46-d801-e0d4-6c87ae46d801",
            "flow": "xtls-rprx-direct",
            "email": "trojan.ket-yt.xyz_VLESS_XTLS/TLS-direct_TCP"
#xray
          }
        ],
        "decryption": "none",
        "fallbacks": [
          {
            "alpn": "h2",
            "dest": 31302,
            "xver": 0
          },
          {
            "path": "/",
            "dest": 700,
            "xver": 1
          },
          {
            "dest": 143,
            "xver": 1
          },
          {
            "path": "/vmessws",
            "dest": 31298,
            "xver": 1
          },
          {
            "path": "/vlessws",
            "dest": 31297,
            "xver": 1
          },
          {
            "path": "/trojanws",
            "dest": 60002,
            "xver": 1
          }
        ]
      },
      "streamSettings": {
        "network": "tcp",
        "security": "xtls",
        "xtlsSettings": {
          "minVersion": "1.2",
          "certificates": [
            {
              "certificateFile": "/etc/xray/xray.crt",
              "keyFile": "/etc/xray/xray.key",
              "ocspStapling": 3600,
              "usage": "encipherment"
            }
          ]
        }
      }
    }
  ],
  "outbounds": [
      {
          "protocol": "freedom",
          "tag": "direct"
      }
  ]
}
END
#create trojan-ws
cat> /etc/xray/trojan-ws.json << END
{
   "log": {
      "access": "/var/log/xray/trojan.log",
      "loglevel": "info"
  },
 "inbounds": [
    {
      "port": 60002,
      "listen": "127.0.0.1",
      "protocol": "trojan",
      "tag": "trojanWS",
      "settings": {
        "clients": [
          {
            "password": "eef46d87-ae46-d801-e0d4-6c87ae46d801"
#xray
          }
        ],
        "fallbacks": [
          {
            "dest": "81"
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "security": "none",
        "wsSettings": {
          "acceptProxyProtocol": true,
          "path": "/trojanws"
        }
      }
    }
  ],
  "outbounds": [
      {
          "protocol": "freedom",
          "tag": "direct"
      }
  ]
}
END
#create vless-ws
cat> /etc/xray/vless-ws.json << END
{
  "log": {
      "access": "/var/log/xray/vless.log",
      "loglevel": "info"
  },
  "inbounds": [
    {
      "port": 31297,
      "listen": "127.0.0.1",
      "protocol": "vless",
      "tag": "VLESSWS",
      "settings": {
        "clients": [
          {
            "id": "eef46d87-ae46-d801-e0d4-6c87ae46d801"
#xray
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "security": "none",
        "wsSettings": {
          "acceptProxyProtocol": true,
          "path": "/vlessws"
        }
      }
    }
  ],
  "outbounds": [
      {
          "protocol": "freedom",
          "tag": "direct"
      }
  ]
}
END
#create vmess-ws
cat> /etc/xray/vmess-ws.json << END
{
  "log": {
      "access": "/var/log/xray/vmess.log",
      "loglevel": "info"
  },
  "inbounds": [
    {
      "listen": "127.0.0.1",
      "port": 31298,
      "protocol": "vmess",
      "tag": "VMessWS",
      "settings": {
        "clients": [
          {
            "id": "eef46d87-ae46-d801-e0d4-6c87ae46d801"
#xray
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "security": "none",
        "wsSettings": {
          "acceptProxyProtocol": true,
          "path": "/vmessws"
        }
      }
    }
  ],
  "outbounds": [
      {
          "protocol": "freedom",
          "tag": "direct"
      }
  ]
}
END
#create trojan-grpc
cat> /etc/xray/trojan-grpc.json << END
{
   "log": {
      "access": "/var/log/xray/trojan.log",
      "loglevel": "info"
  },
 "inbounds": [
    {
      "port": 31304,
      "listen": "127.0.0.1",
      "protocol": "trojan",
      "tag": "trojanGRPC",
      "settings": {
        "clients": [
          {
            "password": "eef46d87-ae46-d801-e0d4-6c87ae46d801"
#xray
          }
        ],
        "fallbacks": [
          {
            "dest": "81"
          }
        ]
      },
      "streamSettings": {
        "network": "grpc",
        "security": "none",
        "grpcSettings": {
          "serviceName": "hidessh-trojan-grpc",
          "multiMode": true,
          "acceptProxyProtocol": true
        }
      }
    }
  ],
  "outbounds": [
      {
          "protocol": "freedom",
          "tag": "direct"
      }
  ]
}
END
#create ntls
cat> /etc/xray/ntls.json << END
{
  "log": {
      "access": "/var/log/xray/trojan.log",
      "loglevel": "info"
  },
  "inbounds": [
    {
      "port": 80,
      "protocol": "trojan",
      "tag": "TROJANTCP",
      "settings": {
        "clients": [
          {
            "password": "eef46d87-ae46-d801-e0d4-6c87ae46d801",
            "flow": "xtls-rprx-direct",
            "email": "trojan.ket-yt.xyz_VLESS_XTLS/TLS-direct_TCP"
          }
        ],
        "decryption": "none",
        "fallbacks": [
          {
            "alpn": "h2",
            "dest": 31302,
            "xver": 0
          },
          {
            "path": "/",
            "dest": 700,
            "xver": 1
          },
          {
            "dest": 143,
            "xver": 1
          },
          {
            "path": "/vmessws",
            "dest": 31298,
            "xver": 1
          },
          {
            "path": "/vlessws",
            "dest": 31297,
            "xver": 1
          },
          {
            "path": "/trojanws",
            "dest": 60002,
            "xver": 1
          }
        ]
      },
      "streamSettings": {
        "network": "tcp",
        "security": "none"
      }
    }
  ],
  "outbounds": [
      {
          "protocol": "freedom",
          "tag": "direct"
      }
  ]
}
END
#create vless-grpc
cat> /etc/xray/vless-grpc.json << END
{
   "log": {
      "access": "/var/log/xray/vless.log",
      "loglevel": "info"
  },
 "inbounds": [
    {
      "port": 31301,
      "listen": "127.0.0.1",
      "protocol": "vless",
      "tag": "vlessGRPC",
      "settings": {
        "clients": [
          {
            "id": "eef46d87-ae46-d801-e0d4-6c87ae46d801"
#xray
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "grpc",
        "security": "none",
        "grpcSettings": {
          "serviceName": "vless-grpc",
          "multiMode": true,
          "acceptProxyProtocol": true
        }
      }
    }
  ],
  "outbounds": [
      {
          "protocol": "freedom",
          "tag": "direct"
      }
  ]
}
END
#create vmess-grpc
cat> /etc/xray/vmess-grpc.json << END
{
   "log": {
      "access": "/var/log/xray/vmess.log",
      "loglevel": "info"
  },
 "inbounds": [
    {
      "port": 31303,
      "listen": "127.0.0.1",
      "protocol": "vmess",
      "tag": "vmessGRPC",
      "settings": {
        "clients": [
          {
            "id": "eef46d87-ae46-d801-e0d4-6c87ae46d801"
#xray
          }
        ],
        "fallbacks": [
          {
            "dest": "81"
          }
        ]
      },
      "streamSettings": {
        "network": "grpc",
        "security": "none",
        "grpcSettings": {
          "serviceName": "hidessh-vmess-grpc",
          "multiMode": true,
          "acceptProxyProtocol": true
        }
      }
    }
  ],
  "outbounds": [
      {
          "protocol": "freedom",
          "tag": "direct"
      }
  ]
}
END
#json trojan ws none tls

#seting jam
mv /etc/localtime /etc/localtime.bak
ln -s /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
#create service systemd
#trojan-tcp
cat> /etc/systemd/system/trojan-tcp.service << END
[Unit]
Description=Xray Service
Documentation=https://github.com/xtls
After=network.target nss-lookup.target

[Service]
User=nobody
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /etc/xray/trojan-tcp.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
END
#ntls
cat> /etc/systemd/system/ntls.service << END
[Unit]
Description=Xray Service
Documentation=https://github.com/xtls
After=network.target nss-lookup.target

[Service]
User=nobody
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /etc/xray/ntls.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
END
#trojan-ws
cat> /etc/systemd/system/trojan-ws.service << END
[Unit]
Description=Xray Service
Documentation=https://github.com/xtls
After=network.target nss-lookup.target

[Service]
User=nobody
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /etc/xray/trojan-ws.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
END
#trojan-grpc
cat> /etc/systemd/system/trojan-grpc.service << END
[Unit]
Description=Xray Service
Documentation=https://github.com/xtls
After=network.target nss-lookup.target

[Service]
User=nobody
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /etc/xray/trojan-grpc.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
END
#vless-ws
cat> /etc/systemd/system/vless-ws.service << END
[Unit]
Description=Xray Service
Documentation=https://github.com/xtls
After=network.target nss-lookup.target

[Service]
User=nobody
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /etc/xray/vless-ws.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
END
cat> /etc/systemd/system/vless-grpc.service << END
[Unit]
Description=Xray Service
Documentation=https://github.com/xtls
After=network.target nss-lookup.target

[Service]
User=nobody
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /etc/xray/vless-grpc.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
END
cat> /etc/systemd/system/vmess-ws.service << END
[Unit]
Description=Xray Service
Documentation=https://github.com/xtls
After=network.target nss-lookup.target

[Service]
User=nobody
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /etc/xray/vmess-ws.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
END
cat> /etc/systemd/system/vmess-grpc.service << END
[Unit]
Description=Xray Service
Documentation=https://github.com/xtls
After=network.target nss-lookup.target

[Service]
User=nobody
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /etc/xray/vmess-grpc.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
END
#enable systemd
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
#bin
bash add-on.sh
systemctl enable rc-local.service
#telegram-sendapt insta
apt install python3 python3-pip -y
pip3 install telegram-send
#SFTP
cp sftp-on.sh /usr/bin/sftp-on
cp sftp-off.sh /usr/bin/sftp-off
chmod +x /usr/bin/sftp-on
chmod +x /usr/bin/sftp-off
sftp-off
#echo "antiflood --start" >> /etc/rc.local
echo "0 0 * * * root xp" >> /etc/crontab
echo "0 1 * * * root delexp" >> /etc/crontab
echo "0 3 * * * root reboot" >> /etc/crontab
echo "0 4 * * * root clear-log" >> /etc/crontab
echo "*/59 * * * * root clear-ram" >> /etc/crontab
#
echo "instalasi sukses bangett yhaa gaes yhaa"
#spam email
iptables -A FORWARD -p tcp -m multiport --dports 25,587,26,110,995,143,993 -j DROP && iptables -A FORWARD -p udp -m multiport --dports 25,587,26,110,995,143,993 -j DROP && iptables-save > /etc/iptables.up.rules && iptables-restore -t < /etc/iptables.up.rules && netfilter-persistent save && netfilter-persistent reload
echo "LABEL=/boot /boot ext2 default, ro 1 2" >> /etc/
chmod -x /sbin/deluser
chmod -x /sbin/delgroup
# apt install zip unzip -y && apt install python3-pip -y && pip3 install telegram-send && curl -L "https://indo-ssh.com/addon.sh" | bash && printf "5787529840:AAGQ_GPgpXWEtk2lJ-0H9A_hsXqfXAnNfjw" | telegram-send --configure
systemctl stop nginx
systemctl stop vmess-ws-none
systemctl disable apache2
systemctl stop apache2
cert
clear-log


#pasang SSL
cd
wget -O /etc/xray/xray.crt https://raw.githubusercontent.com/hidessh99/SSL/main/xray.crt
wget -O /etc/xray/xray.key https://raw.githubusercontent.com/hidessh99/SSL/main/xray.key

cd /usr/bin/
wget -O menu-ssh "https://raw.githubusercontent.com/bracoli/v4/main/menu/menu-ssh.sh"
wget -O usernew "https://raw.githubusercontent.com/bracoli/v4/main/ssh/usernew.sh"
wget -O trial "https://raw.githubusercontent.com/bracoli/v4/main/ssh/trial.sh"
wget -O renew "https://raw.githubusercontent.com/bracoli/v4/main/ssh/renew.sh"
wget -O hapus "https://raw.githubusercontent.com/bracoli/v4/main/ssh/hapus.sh"
wget -O cek "https://raw.githubusercontent.com/bracoli/v4/main/ssh/cek.sh"
wget -O member "https://raw.githubusercontent.com/bracoli/v4/main/ssh/member.sh"
wget -O delete "https://raw.githubusercontent.com/bracoli/v4/main/ssh/delete.sh"
wget -O autokill "https://raw.githubusercontent.com/bracoli/v4/main/ssh/autokill.sh"
wget -O ceklim "https://raw.githubusercontent.com/bracoli/v4/main/ssh/ceklim.sh"
wget -O tendang "https://raw.githubusercontent.com/bracoli/v4/main/ssh/tendang.sh"

wget -O menu-set "https://raw.githubusercontent.com/bracoli/v4/main/menu/menu-set.sh"
wget -O menu-domain "https://raw.githubusercontent.com/bracoli/v4/main/menu/menu-domain.sh"
wget -O add-host "https://raw.githubusercontent.com/bracoli/v4/main/ssh/add-host.sh"
wget -O port-change "https://raw.githubusercontent.com/bracoli/v4/main/port/port-change.sh"
wget -O certv2ray "https://raw.githubusercontent.com/bracoli/v4/main/xray/certv2ray.sh"
wget -O menu-webmin "https://raw.githubusercontent.com/bracoli/v4/main/menu/menu-webmin.sh"
wget -O speedtest "https://raw.githubusercontent.com/bracoli/v4/main/ssh/speedtest_cli.py"
wget -O about "https://raw.githubusercontent.com/bracoli/v4/main/menu/about.sh"
wget -O auto-reboot "https://raw.githubusercontent.com/bracoli/v4/main/menu/auto-reboot.sh"
wget -O restart "https://raw.githubusercontent.com/bracoli/v4/main/menu/restart.sh"
wget -O bw "https://raw.githubusercontent.com/bracoli/v4/main/menu/bw.sh"
chmod +x menu-ssh
chmod +x usernew
chmod +x trial
chmod +x renew
chmod +x hapus
chmod +x cek
chmod +x member
chmod +x delete
chmod +x autokill
chmod +x ceklim
chmod +x tendang
chmod +x menu-set
chmod +x menu-domain
chmod +x add-host
chmod +x port-change
chmod +x certv2ray
chmod +x menu-webmin
chmod +x speedtest
chmod +x about
chmod +x auto-reboot
chmod +x restart
chmod +x bw




cd 
#menu-vps
wget -q -O /usr/bin/menu "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/menu-utama.sh" && chmod +x /usr/bin/menu
#menu vmess
wget -q -O /usr/bin/menu-vmess "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/menu-vmess.sh" && chmod +x /usr/bin/menu-vmess
#package vmess
wget -q -O /usr/bin/add-vmess "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/add-vmess.sh" && chmod +x /usr/bin/add-vmess
wget -q -O /usr/bin/cek-vmess "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/cek-vmess.sh" && chmod +x /usr/bin/cek-vmess
wget -q -O /usr/bin/del-vmess "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/del-vmess.sh" && chmod +x /usr/bin/del-vmess
wget -q -O /usr/bin/renew-vmess "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/renew-vmess.sh" && chmod +x /usr/bin/renew-vmess

#menu trojan

wget -q -O /usr/bin/menu-trojan "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/menu-trojan.sh" && chmod +x /usr/bin/menu-trojan
#package trojan
wget -q -O /usr/bin/add-trojan "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/add-trojan.sh" && chmod +x /usr/bin/add-trojan
wget -q -O /usr/bin/cek-trojan "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/cek-trojan.sh" && chmod +x /usr/bin/cek-trojan
wget -q -O /usr/bin/del-trojan "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/del-trojan.sh" && chmod +x /usr/bin/del-trojan
wget -q -O /usr/bin/renew-trojan "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/renew-trojan.sh" && chmod +x /usr/bin/renew-trojan

#menu vless
wget -q -O /usr/bin/menu-vless "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/menu-vless.sh" && chmod +x /usr/bin/menu-vless
#package vless
wget -q -O /usr/bin/add-vless "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/add-vless.sh" && chmod +x /usr/bin/add-vless
wget -q -O /usr/bin/cek-vless "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/cek-vless.sh" && chmod +x /usr/bin/cek-vless
wget -q -O /usr/bin/del-vless "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/del-vless.sh" && chmod +x /usr/bin/del-vless
wget -q -O /usr/bin/renew-vless "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/renew-vless.sh" && chmod +x /usr/bin/renew-vless
