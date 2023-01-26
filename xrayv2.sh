#!/bin/bash
rm -rf xray
clear
NC='\e[0m'
DEFBOLD='\e[39;1m'
RB='\e[31;1m'
GB='\e[32;1m'
YB='\e[33;1m'
BB='\e[34;1m'
MB='\e[35;1m'
CB='\e[35;1m'
WB='\e[37;1m'
secs_to_human() {
echo -e "${WB}Installation time : $(( ${1} / 3600 )) hours $(( (${1} / 60) % 60 )) minute's $(( ${1} % 60 )) seconds${NC}"
}
start=$(date +%s)
apt update -y
apt full-upgrade -y
apt dist-upgrade -y
apt install socat curl screen cron screenfetch netfilter-persistent vnstat lsof fail2ban -y
mkdir /backup > /dev/null 2>&1
mkdir /user > /dev/null 2>&1
mkdir /tmp > /dev/null 2>&1
clear
vnstat --remove -i eth1 --force
clear
rm /usr/local/etc/xray/city > /dev/null 2>&1
rm /usr/local/etc/xray/org > /dev/null 2>&1
rm /usr/local/etc/xray/timezone > /dev/null 2>&1
bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" - install --beta
cp /usr/local/bin/xray /backup/xray.official.backup
curl -s ipinfo.io/city >> /usr/local/etc/xray/city
curl -s ipinfo.io/org | cut -d " " -f 2-10 >> /usr/local/etc/xray/org
curl -s ipinfo.io/timezone >> /usr/local/etc/xray/timezone
clear
echo -e "${GB}[ INFO ]${NC} ${YB}Downloading Xray-core mod${NC}"
sleep 0.5
wget -q -O /backup/xray.mod.backup "https://github.com/dharak36/Xray-core/releases/download/v1.0.0/xray.linux.64bit"
echo -e "${GB}[ INFO ]${NC} ${YB}Download Xray-core done${NC}"
sleep 1
cd
clear
sudo apt-get install lolcat -y
clear
source <(curl -sL  https://raw.githubusercontent.com/xxxserxxx/gotop/master/scripts/download.sh)
clear
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
apt install nginx -y
rm /var/www/html/*.html
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
cd /var/www/htm/ 
wget https://raw.githubusercontent.com/arismaramar/gif/main/fodder/web.zip
unzip -x web.zip 
chmod +x /var/www/html/*
cd
mkdir -p /var/www/html/vmess
mkdir -p /var/www/html/vless
mkdir -p /var/www/html/trojan
mkdir -p /var/www/html/shadowsocks
mkdir -p /var/www/html/shadowsocks2022
mkdir -p /var/www/html/socks5
mkdir -p /var/www/html/allxray
mkdir /usr/local/ddos
systemctl restart nginx
clear
touch /usr/local/etc/xray/domain
echo -e "${YB}Input Domain${NC} "
echo " "
read -rp "Input your domain : " -e dns
if [ -z $dns ]; then
echo -e "Nothing input for domain!"
else
echo "$dns" > /usr/local/etc/xray/domain
echo "DNS=$dns" > /var/lib/dnsvps.conf
fi
clear
systemctl stop nginx
domain=$(cat /usr/local/etc/xray/domain)
curl https://get.acme.sh | sh
source ~/.bashrc
cd .acme.sh
bash acme.sh --issue -d $domain --server letsencrypt --keylength ec-256 --fullchain-file /usr/local/etc/xray/fullchain.crt --key-file /usr/local/etc/xray/private.key --standalone --force
clear
echo -e "${GB}[ INFO ]${NC} ${YB}Setup Nginx & Xray Conf${NC}"

# Set Xray Conf
# Setting
uuid=$(cat /proc/sys/kernel/random/uuid)
cipher="aes-128-gcm"
cipher2="2022-blake3-aes-128-gcm"
serverpsk=$(openssl rand -base64 16)
userpsk=$(openssl rand -base64 16)
echo "$serverpsk" > /usr/local/etc/xray/serverpsk
# Set Xray Conf
cat > /usr/local/etc/xray/config.json << END
{
  "log" : {
    "access": "/var/log/xray/access.log",
    "error": "/var/log/xray/error.log",
    "loglevel": "info"
  },
  "inbounds": [
    {
      "listen": "127.0.0.1",
      "port": "10001",
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "$uuid",
            "alterId": 0
#vmess
          }
        ]
      },
      "streamSettings":{
        "network": "ws",
        "wsSettings": {
          "path": "/vmess",
          "alpn": [
            "h2",
            "http/1.1"
          ]
        }
      }
    },
    {
      "listen": "127.0.0.1",
      "port": "10002",
      "protocol": "vless",
      "settings": {
        "decryption":"none",
        "clients": [
          {
            "id": "$uuid"
#vless
          }
        ]
      },
      "streamSettings":{
        "network": "ws",
        "wsSettings": {
          "path": "/vless",
          "alpn": [
            "h2",
            "http/1.1"
          ]
        }
      }
    },
    {
      "listen": "127.0.0.1",
      "port": "10003",
      "protocol": "trojan",
      "settings": {
        "decryption":"none",
        "clients": [
          {
            "password": "$uuid"
#trojan
          }
        ]
      },
      "streamSettings":{
        "network": "ws",
        "wsSettings": {
          "path": "/trojan",
          "alpn": [
            "h2",
            "http/1.1"
          ]
        }
      }
    },
    {
      "listen": "127.0.0.1",
      "port": "10006",
      "protocol": "shadowsocks",
      "settings": {
        "clients": [
            {
              "method": "$cipher",
              "password": "$uuid"
#shadowsocks
            }
          ],
        "network": "tcp,udp"
      },
      "streamSettings":{
        "network": "ws",
        "wsSettings": {
          "path": "/shadowsocks",
          "alpn": [
            "h2",
            "http/1.1"
          ]
        }
      }
    },
    {
      "listen": "127.0.0.1",
      "port": "10005",
      "protocol": "shadowsocks",
      "settings": {
        "method": "$cipher2",
        "password": "$serverpsk",
        "clients": [
          {
            "password": "$userpsk"
#shadowsocks2022
          }
        ],
        "network": "tcp,udp"
      },
      "streamSettings":{
        "network": "ws",
        "wsSettings": {
          "path": "/shadowsocks2022",
          "alpn": [
            "h2",
            "http/1.1"
          ]
        }
      }
    },
    {
      "listen": "127.0.0.1",
      "port": "10006",
      "protocol": "socks",
      "settings": {
        "auth": "password",
        "accounts": [
            {
              "user": "private",
              "pass": "server"
#socks
            }
          ],
        "udp": true,
        "ip": "127.0.0.1"
      },
      "streamSettings":{
        "network": "ws",
        "wsSettings": {
          "path": "/socks5",
          "alpn": [
            "h2",
            "http/1.1"
          ]
        }
      }
    },
    {
      "listen": "127.0.0.1",
      "port": "20001",
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "$uuid",
            "alterId": 0
#vmess-grpc
          }
        ]
      },
      "streamSettings":{
        "network": "grpc",
        "grpcSettings": {
          "serviceName": "vmess-grpc",
          "alpn": [
            "h2",
            "http/1.1"
          ]
        }
      }
    },
    {
      "listen": "127.0.0.1",
      "port": "20002",
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "$uuid",
            "alterId": 0
#vmess-grpc
          }
        ]
      },
      "streamSettings":{
        "network": "grpc",
        "grpcSettings": {
          "serviceName": "vmess-grpc",
          "alpn": [
            "h2",
            "http/1.1"
          ]
        }
      }
    },
    {
      "listen": "127.0.0.1",
      "port": "20002",
      "protocol": "vless",
      "settings": {
        "decryption":"none",
        "clients": [
          {
            "id": "$uuid"
#vless-grpc
          }
        ]
      },
      "streamSettings":{
        "network": "grpc",
        "grpcSettings": {
          "serviceName": "vless-grpc",
          "alpn": [
            "h2",
            "http/1.1"
          ]
        }
      }
    },
    {
      "listen": "127.0.0.1",
      "port": "20003",
      "protocol": "trojan",
      "settings": {
        "decryption":"none",
        "clients": [
          {
            "password": "$uuid"
#trojan-grpc
          }
        ],
        "udp": true
      },
      "streamSettings":{
        "network": "grpc",
        "grpcSettings": {
          "serviceName": "trojan-grpc",
          "alpn": [
            "h2",
            "http/1.1"
          ]
        }
      }
    },
    {
      "listen": "127.0.0.1",
      "port": "20004",
      "protocol": "shadowsocks",
      "settings": {
        "clients": [
            {
              "method": "$cipher",
              "password": "$uuid"
#shadowsocks-grpc
            }
          ],
        "network": "tcp,udp"
      },
      "streamSettings":{
        "network": "grpc",
        "grpcSettings": {
          "serviceName": "shadowsocks-grpc",
          "alpn": [
            "h2",
            "http/1.1"
          ]
        }
      }
    },
    {
      "listen": "127.0.0.1",
      "port": "20005",
      "protocol": "shadowsocks",
      "settings": {
        "method": "$cipher2",
        "password": "$serverpsk",
        "clients": [
          {
            "password": "$userpsk"
#shadowsocks2022-grpc
          }
        ],
        "network": "tcp,udp"
      },
      "streamSettings":{
        "network": "grpc",
        "grpcSettings": {
          "serviceName": "shadowsocks2022-grpc",
          "alpn": [
            "h2",
            "http/1.1"
          ]
        }
      }
    },
    {
      "listen": "127.0.0.1",
      "port": "20006",
      "protocol": "socks",
      "settings": {
        "auth": "password",
        "accounts": [
            {
              "user": "private",
              "pass": "server"
#socks-grpc
            }
          ],
        "udp": true,
        "ip": "127.0.0.1"
      },
      "streamSettings":{
        "network": "grpc",
        "grpcSettings": {
          "serviceName": "socks5-grpc",
          "alpn": [
            "h2",
            "http/1.1"
          ]
        }
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "tag": "direct"
    },
    {
      "protocol": "blackhole",
      "tag": "block"
    }
  ]
}

END
wget -q -O /etc/nginx/nginx.conf "https://raw.githubusercontent.com/arismaramar/scxray/main/other/nginx.conf" >/dev/null 2>&1
wget -q -O /etc/nginx/conf.d/xray.conf "https://raw.githubusercontent.com/arismaramar/scxray/main/other/xray.conf" >/dev/null 2>&1
sed -i "s/xxx/${domain}/g" /etc/nginx/conf.d/xray.conf
sed -i "s/xxx/${domain}/g" /etc/nginx/nginx.conf
sed -i "s/xxx/${domain}/g" /var/www/html/index.html
systemctl restart nginx
systemctl restart xray
echo -e "${GB}[ INFO ]${NC} ${YB}Setup Done${NC}"
sleep 2
clear
iptables -A FORWARD -m string --string "get_peers" --algo bm -j DROP
iptables -A FORWARD -m string --string "announce_peer" --algo bm -j DROP
iptables -A FORWARD -m string --string "find_node" --algo bm -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
iptables -A FORWARD -m string --algo bm --string ".torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
iptables -A FORWARD -m string --algo bm --string "torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce" -j DROP
iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sed -i '/fs.file-max/d' /etc/sysctl.conf
sed -i '/fs.inotify.max_user_instances/d' /etc/sysctl.conf
sed -i '/net.ipv4.tcp_syncookies/d' /etc/sysctl.conf
sed -i '/net.ipv4.tcp_fin_timeout/d' /etc/sysctl.conf
sed -i '/net.ipv4.tcp_tw_reuse/d' /etc/sysctl.conf
sed -i '/net.ipv4.tcp_max_syn_backlog/d' /etc/sysctl.conf
sed -i '/net.ipv4.ip_local_port_range/d' /etc/sysctl.conf
sed -i '/net.ipv4.tcp_max_tw_buckets/d' /etc/sysctl.conf
sed -i '/net.ipv4.route.gc_timeout/d' /etc/sysctl.conf
sed -i '/net.ipv4.tcp_synack_retries/d' /etc/sysctl.conf
sed -i '/net.ipv4.tcp_syn_retries/d' /etc/sysctl.conf
sed -i '/net.core.somaxconn/d' /etc/sysctl.conf
sed -i '/net.core.netdev_max_backlog/d' /etc/sysctl.conf
sed -i '/net.ipv4.tcp_timestamps/d' /etc/sysctl.conf
sed -i '/net.ipv4.tcp_max_orphans/d' /etc/sysctl.conf
sed -i '/net.ipv4.ip_forward/d' /etc/sysctl.conf
echo "fs.file-max = 1000000
fs.inotify.max_user_instances = 8192
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_fin_timeout = 30
net.ipv4.tcp_tw_reuse = 1
net.ipv4.ip_local_port_range = 1024 65000
net.ipv4.tcp_max_syn_backlog = 16384
net.ipv4.tcp_max_tw_buckets = 6000
net.ipv4.route.gc_timeout = 100
net.ipv4.tcp_syn_retries = 1
net.ipv4.tcp_synack_retries = 1
net.core.somaxconn = 32768
net.core.netdev_max_backlog = 32768
net.ipv4.tcp_timestamps = 0
net.ipv4.tcp_max_orphans = 32768
net.ipv4.ip_forward = 1" >> /etc/sysctl.conf

# Instal DDOS Flate
clear
echo; echo 'Installing DOS-Deflate 0.6'; echo
echo; echo -n 'Downloading source files...'
wget -q -O /usr/local/ddos/ddos.conf http://www.inetbase.com/scripts/ddos/ddos.conf
echo -n '.'
wget -q -O /usr/local/ddos/LICENSE http://www.inetbase.com/scripts/ddos/LICENSE
echo -n '.'
wget -q -O /usr/local/ddos/ignore.ip.list http://www.inetbase.com/scripts/ddos/ignore.ip.list
echo -n '.'
wget -q -O /usr/local/ddos/ddos.sh http://www.inetbase.com/scripts/ddos/ddos.sh
chmod 0755 /usr/local/ddos/ddos.sh
cp -s /usr/local/ddos/ddos.sh /usr/local/sbin/ddos
echo '...done'
echo; echo -n 'Creating cron to run script every minute.....(Default setting)'
/usr/local/ddos/ddos.sh --cron > /dev/null 2>&1
echo '.....done'
echo; echo 'Installation has completed.'
echo 'Config file is at /usr/local/ddos/ddos.conf'
echo 'Please send in your comments and/or suggestions to zaf@vsnl.com'

cd /usr/bin
echo -e "${GB}[ INFO ]${NC} ${YB}Downloading Main Menu${NC}"
wget -q -O menu "https://raw.githubusercontent.com/arismaramar/scxray/main/menu/menu.sh"
wget -q -O vmess "https://raw.githubusercontent.com/arismaramar/scxray/main/menu/vmess.sh"
wget -q -O vless "https://raw.githubusercontent.com/arismaramar/scxray/main/menu/vless.sh"
wget -q -O trojan "https://raw.githubusercontent.com/arismaramar/scxray/main/menu/trojan.sh"
wget -q -O shadowsocks "https://raw.githubusercontent.com/arismaramar/scxray/main/menu/shadowsocks.sh"
wget -q -O shadowsocks2022 "https://raw.githubusercontent.com/arismaramar/scxray/main/menu/shadowsocks2022.sh"
wget -q -O socks "https://raw.githubusercontent.com/arismaramar/scxray/main/menu/socks.sh"
wget -q -O allxray "https://raw.githubusercontent.com/arismaramar/scxray/main/menu/allxray.sh"
sleep 0.5
echo -e "${GB}[ INFO ]${NC} ${YB}Downloading Menu Vmess${NC}"
wget -q -O add-vmess "https://raw.githubusercontent.com/arismaramar/scxray/main/vmess/add-vmess.sh"
wget -q -O del-vmess "https://raw.githubusercontent.com/arismaramar/scxray/main/vmess/del-vmess.sh"
wget -q -O extend-vmess "https://raw.githubusercontent.com/arismaramar/scxray/main/vmess/extend-vmess.sh"
wget -q -O trialvmess "https://raw.githubusercontent.com/arismaramar/scxray/main/vmess/trialvmess.sh"
wget -q -O cek-vmess "https://raw.githubusercontent.com/arismaramar/scxray/main/vmess/cek-vmess.sh" 
sleep 0.5
echo -e "${GB}[ INFO ]${NC} ${YB}Downloading Menu Vless${NC}"
wget -q -O add-vless "https://raw.githubusercontent.com/arismaramar/scxray/main/vless/add-vless.sh"
wget -q -O del-vless "https://raw.githubusercontent.com/arismaramar/scxray/main/vless/del-vless.sh"
wget -q -O extend-vless "https://raw.githubusercontent.com/arismaramar/scxray/main/vless/extend-vless.sh"
wget -q -O trialvless "https://raw.githubusercontent.com/arismaramar/scxray/main/vless/trialvless.sh"
wget -q -O cek-vless "https://raw.githubusercontent.com/arismaramar/scxray/main/vless/cek-vless.sh"
sleep 0.5
echo -e "${GB}[ INFO ]${NC} ${YB}Downloading Menu Trojan${NC}"
wget -q -O add-trojan "https://raw.githubusercontent.com/arismaramar/scxray/main/trojan/add-trojan.sh"
wget -q -O del-trojan "https://raw.githubusercontent.com/arismaramar/scxray/main/trojan/del-trojan.sh"
wget -q -O extend-trojan "https://raw.githubusercontent.com/arismaramar/ALL-XRAY/main/trojan/extend-trojan.sh"
wget -q -O trialtrojan "https://raw.githubusercontent.com/arismaramar/scxray/trojan/trialtrojan.sh"
wget -q -O cek-trojan "https://raw.githubusercontent.com/arismaramar/scxray/trojan/cek-trojan.sh"
sleep 0.5
echo -e "${GB}[ INFO ]${NC} ${YB}Downloading Menu Shadowsocks${NC}"
wget -q -O add-ss "https://raw.githubusercontent.com/arismaramar/scxray/main/shadowsocks/add-ss.sh"
wget -q -O del-ss "https://raw.githubusercontent.com/arismaramar/scxray/main/shadowsocks/del-ss.sh"
wget -q -O extend-ss "https://raw.githubusercontent.com/arismaramar/scxray/main/shadowsocks/extend-ss.sh"
wget -q -O trialss "https://raw.githubusercontent.com/arismaramar/scxray/main/shadowsocks/trial-ss.sh"
wget -q -O cek-ss "https://raw.githubusercontent.com/arismaramar/scxray/main/shadowsocks/cek-ss.sh"
sleep 0.5
echo -e "${GB}[ INFO ]${NC} ${YB}Downloading Menu Shadowsocks 2022${NC}"
wget -q -O add-ss2022 "https://raw.githubusercontent.com/arismaramar/scxray/main/shadowsocks2022/add-ss2022.sh"
wget -q -O del-ss2022 "https://raw.githubusercontent.com/arismaramar/scxray/main/shadowsocks2022/del-ss2022.sh"
wget -q -O extend-ss2022 "https://raw.githubusercontent.com/arismaramar/scxray/main/shadowsocks2022/extend-ss2022.sh"
wget -q -O trialss2022 "https://raw.githubusercontent.com/arismaramar/ scxray/main/shadowsocks2022/trialss2022.sh"
wget -q -O cek-ss2022 "https://raw.githubusercontent.com/arismaramar/scxray/main/shadowsocks2022/cek-ss2022.sh"
sleep 0.5
echo -e "${GB}[ INFO ]${NC} ${YB}Downloading Menu Socks5${NC}"
wget -q -O add-socks "https://raw.githubusercontent.com/arismaramar/scxray/main/socks/add-socks.sh"
wget -q -O del-socks "https://raw.githubusercontent.com/arismaramar/scxray/main/socks/del-socks.sh"
wget -q -O extend-socks "https://raw.githubusercontent.com/arismaramar/scxray/main/socks/extend-socks.sh"
wget -q -O trialsocks "https://raw.githubusercontent.com/arismaramar/scxray/main/socks/trialsocks.sh"
wget -q -O cek-socks "https://raw.githubusercontent.com/arismaramar/scxray/main/socks/cek-socks.sh"
sleep 0.5
echo -e "${GB}[ INFO ]${NC} ${YB}Downloading Menu All Xray${NC}"
wget -q -O add-xray "https://raw.githubusercontent.com/arismaramar/scxray/main/allxray/add-xray.sh"
wget -q -O del-xray "https://raw.githubusercontent.com/arismaramar/scxray/main/allxray/del-xray.sh"
wget -q -O extend-xray "https://raw.githubusercontent.com/arismaramar/scxray/main/allxray/extend-xray.sh"
wget -q -O trialxray "https://raw.githubusercontent.com/arismaramar/scxray/main/allxray/trialxray.sh"
wget -q -O cek-xray "https://raw.githubusercontent.com/arismaramar/scxray/main/allxray/cek-xray.sh"
sleep 0.5
echo -e "${GB}[ INFO ]${NC} ${YB}Downloading Menu Log${NC}"
wget -q -O log-create "https://raw.githubusercontent.com/arismaramar/scxray/main/log/log-create.sh"
wget -q -O log-vmess "https://raw.githubusercontent.com/arismaramar/scxray/main/log/log-vmess.sh"
wget -q -O log-vless "https://raw.githubusercontent.com/arismaramar/scxray/main/log/log-vless.sh"
wget -q -O log-trojan "https://raw.githubusercontent.com/arismaramar/scxray/main/log/log-trojan.sh"
wget -q -O log-ss "https://raw.githubusercontent.com/arismaramar/ALL-XRAY/main/log/log-ss.sh"
wget -q -O log-ss2022 "https://raw.githubusercontent.com/arismaramar/scxray/main/log/log-ss2022.sh"
wget -q -O log-socks "https://raw.githubusercontent.com/arismaramar/scxray/main/log/log-socks.sh"
wget -q -O log-allxray "https://raw.githubusercontent.com/arismaramar/scxray/main/log/log-allxray.sh"
sleep 0.5
echo -e "${GB}[ INFO ]${NC} ${YB}Downloading Other Menu${NC}"
wget -q -O xp "https://raw.githubusercontent.com/arismaramar/scxray/main/other/xp.sh"
wget -q -O dns "https://raw.githubusercontent.com/arismaramar/scxray/main/other/dns.sh"
wget -q -O certxray "https://raw.githubusercontent.com/arismaramar/scxray/main/other/certxray.sh"
wget -q -O xraymod "https://raw.githubusercontent.com/arismaramar/scxray/main/other/xraymod.sh"
wget -q -O xrayofficial "https://raw.githubusercontent.com/arismaramar/scxray/main/other/xrayofficial.sh"
wget -q -O about "https://raw.githubusercontent.com/arismaramar/scxray/main/other/about.sh"
wget -q -O clear-log "https://raw.githubusercontent.com/arismaramar/scxray/main/other/clear-log.sh"
echo -e "${GB}[ INFO ]${NC} ${YB}Download All Menu Done${NC}"
wget -q -O speedtest "https://raw.githubusercontent.com/arismaramar/supreme/aio/ssh/speedtest_cli.py"
apt-get install speedtest
sleep 2
chmod +x add-vmess
chmod +x del-vmess
chmod +x extend-vmess
chmod +x trialvmess
chmod +x cek-vmess
chmod +x add-vless
chmod +x del-vless
chmod +x extend-vless
chmod +x trialvless
chmod +x cek-vless
chmod +x add-trojan
chmod +x del-trojan
chmod +x extend-trojan
chmod +x trialtrojan
chmod +x cek-trojan
chmod +x add-ss
chmod +x del-ss
chmod +x extend-ss
chmod +x trialss
chmod +x cek-ss
chmod +x add-ss2022
chmod +x del-ss2022
chmod +x extend-ss2022
chmod +x trialss2022
chmod +x cek-ss2022
chmod +x add-socks
chmod +x del-socks
chmod +x extend-socks
chmod +x trialsocks
chmod +x cek-socks
chmod +x add-xray
chmod +x del-xray
chmod +x extend-xray
chmod +x trialxray
chmod +x cek-xray
chmod +x log-create
chmod +x log-vmess
chmod +x log-vless
chmod +x log-trojan
chmod +x log-ss
chmod +x log-ss2022
chmod +x log-socks
chmod +x log-allxray
chmod +x menu
chmod +x vmess
chmod +x vless
chmod +x trojan
chmod +x shadowsocks
chmod +x shadowsocks2022
chmod +x socks
chmod +x allxray
chmod +x xp
chmod +x dns
chmod +x certxray
chmod +x xraymod
chmod +x xrayofficial
chmod +x about
chmod +x clear-log
chmod +x speedtest
cd
echo "0 0 * * * root xp" >> /etc/crontab
echo "*/5 * * * * root clear-log" >> /etc/crontab
systemctl restart cron
cat > /root/.profile << END
if [ "$BASH" ]; then
if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi
fi
mesg n || true
clear
menu
END
chmod 644 /root/.profile
clear
echo ""
echo ""
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" |  
echo ""
echo -e "                ${WB}DEV SCRIPT BY DUGONG REV ANGGUN${NC}"
echo ""
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | 
echo -e "  ${WB}»»» Protocol Service «««  |  »»» Network Protocol «««${NC}  "
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | 
echo -e "  ${YB}- Vless${NC}                   ${WB}|${NC}  ${YB}- Websocket (CDN) non TLS${NC}"
echo -e "  ${YB}- Vmess${NC}                   ${WB}|${NC}  ${YB}- Websocket (CDN) TLS${NC}"
echo -e "  ${YB}- Trojan${NC}                  ${WB}|${NC}  ${YB}- gRPC (CDN) TLS${NC}"
echo -e "  ${YB}- Socks5${NC}                  ${WB}|${NC}"
echo -e "  ${YB}- Shadowsocks${NC}             ${WB}|${NC}"
echo -e "  ${YB}- Shadowsocks 2022${NC}        ${WB}|${NC}"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | 
echo -e "               ${WB}»»» Network Port Service «««${NC}     "
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | 
echo -e "  ${YB}- HTTPS : 443, 2053, 2083, 2087, 2096, 8443${NC}"
echo -e "  ${YB}- HTTP  : 80, 8080, 8880, 2052, 2082, 2086, 2095${NC}"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" |
echo ""
rm -f xray
secs_to_human "$(($(date +%s) - ${start}))"
echo -e "${YB}[ WARNING ] reboot now ? (Y/N)${NC} "
read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
exit 0
else
reboot
fi
