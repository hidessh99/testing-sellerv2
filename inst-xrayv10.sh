#!/bin/bash
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
mkdir /etc/v2ray
mkdir /var/lib/scrz-prem/
touch /etc/xray/domain
touch /etc/v2ray/domain
touch /etc/xray/scdomain
touch /etc/v2ray/scdomain
touch /var/lib/scrz-prem/ipvps.conf

wget -q https://raw.githubusercontent.com/hidessh99/Package-Seller-SSH/main/add-dns.sh;chmod +x add-dns.sh;./add-dns.sh

#send
domain=$(cat /root/subdomain)
nsdomain=$(cat /root/nsdomain)
#echo $domain >> /etc/xray/domain
echo $ipku >> /etc/xray/public
#send

echo $nsdomain >> /etc/xray/nsdomain
echo $ipku >> /etc/xray/public
#echo $resdomain >> /etc/xray/resdomain
#echo $author >> /etc/nur/author
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
<font color="red"><b>********  HideSSH  ********</b></font><br>
<font color="blue"><b>===============================</br></font><br>
END

cd
#seting jam
mv /etc/localtime /etc/localtime.bak
ln -s /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
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

#BBR
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sysctl -p

#install xray
bash -c "$(curl -L https://raw.githubusercontent.com/adisubagja/Xray-install/main/install-release.sh)" @ install --beta

#Xray Port 443 
wget -O /etc/xray/trojan-tcp.json "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/funy2-json/trojan-tcp.json"
#Xray Port 80
wget -O /etc/xray/ntls.json "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/xrayv3/ntls.json"
#Xray NTLS 55
wget -O /etc/xray/ntls-55.json "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/funy2-json/ntls-55.json"


#nginx port 81
wget -O /etc/nginx/conf.d/funnvpn.conf "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/xrayv3/hide-nginx.conf"

#Xray Trojan WS
wget -O /etc/xray/trojan-ws.json "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/funy2-json/trojan-ws.json"
#Xray Vless WS
wget -O /etc/xray/vless-ws.json "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/funy2-json/vless-ws.json"
#Xray Vmess WS
wget -O /etc/xray/vmess-ws.json "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/funy2-json/vmess-ws.json"

#Xray Trojan GRPC
wget -O /etc/xray/trojan-grpc.json "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/funy2-json/trojan-grpc.json"
#Xray Vless GRPC
wget -O /etc/xray/vless-grpc.json "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/funy2-json/vless-grpc.json"
#Xray Vmess GRPC
wget -O /etc/xray/vmess-grpc.json "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/funy2-json/vmess-grpc.json"

#xray WorryFree
wget -O /etc/xray/worryfree.json "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/funy2-json/vmess-ws-orbit.json"
#xray KoutaHabis
wget -O /etc/xray/koutahabis.json "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/funy2-json/vmess-ws-orbit1.json"

#servive worryfree
wget -O /etc/systemd/system/worryfree.service "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/service/worryfree.service"
#service koutahabis
wget -O /etc/systemd/system/koutahabis.service "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/service/koutahabis.service"

#Service NTLS Port 80
wget -O /etc/systemd/system/ntls.service "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/service/ntls.service"
#Service NTLS Port 55
wget -O /etc/systemd/system/ntls-55.service "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/service/ntls-55.service"
#Service  Trojan Port 443
wget -O /etc/systemd/system/trojan-tcp.service "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/service/trojan-tcp.service"

#Service Trojan WS
wget -O /etc/systemd/system/trojan-ws.service "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/service/trojan-ws.service"
#Service Trojan GRPC
wget -O /etc/systemd/system/trojan-grpc.service "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/service/trojan-grpc.service"

#Service Vless WS
wget -O /etc/systemd/system/vless-ws.service "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/service/vless-ws.service"
#Service Vless GRPC
wget -O /etc/systemd/system/vless-grpc.service "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/service/vless-grpc.service"

#Service Vmess WS
wget -O /etc/systemd/system/vmess-ws.service "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/service/vmess-ws.service"
#Service Vmess GRPC
wget -O /etc/systemd/system/vmess-grpc.service "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/service/vmess-grpc.service"

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

echo "instalasi sukses bangett yhaa gaes yhaa"
#spam email
iptables -A FORWARD -p tcp -m multiport --dports 25,587,26,110,995,143,993 -j DROP && iptables -A FORWARD -p udp -m multiport --dports 25,587,26,110,995,143,993 -j DROP && iptables-save > /etc/iptables.up.rules && iptables-restore -t < /etc/iptables.up.rules && netfilter-persistent save && netfilter-persistent reload
echo "LABEL=/boot /boot ext2 default, ro 1 2" >> /etc/
chmod -x /sbin/deluser
chmod -x /sbin/delgroup
systemctl stop nginx
systemctl stop vmess-ws-none
systemctl disable apache2
systemctl stop apache2
cert
clear-log

#install  SSL
cd
wget -O /etc/xray/xray.crt https://raw.githubusercontent.com/hidessh99/SSL/main/xray.crt
wget -O /etc/xray/xray.key https://raw.githubusercontent.com/hidessh99/SSL/main/xray.key

cd 
#package SSH
wget https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/pckg-new.sh;chmod +x;pckg-new.sh;./pckg-new.sh

#menu-vps
wget -q -O /usr/bin/menu "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/menu-utama.sh" && chmod +x /usr/bin/menu
#menu vmess
wget -q -O /usr/bin/menu-vmess "https://raw.githubusercontent.com/hidessh99/testing-sellerv2/main/menu-vmess.sh" && chmod +x /usr/bin/menu-vmess
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

wget -q -O /usr/bin/removelog "https://raw.githubusercontent.com/hidessh99/Package-Seller-SSH/main/remove-log.sh" && chmod +x /usr/bin/removelog

echo "0 */2 * * * root userdelexpired" >> /etc/crontab
echo "0 1 * * * root removelog" >> /etc/crontab
echo "0 0 * * * root xp" >> /etc/crontab
echo "0 2 * * * root reboot" >> /etc/crontab

#restart service
systemctl restart trojan-tcp
systemctl restart trojan-ws
systemctl restart trojan-grpc
systemctl restart vless-ws
systemctl restart vless-grpc
systemctl restart vmess-ws
systemctl restart vmess-grpc
systemctl restart ntls
systemctl restart nginx