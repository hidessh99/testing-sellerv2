#!/bin/bash
#tambah akun SSH
wget -O /usr/local/bin/add-ssh-user "https://raw.githubusercontent.com/hidessh99/Package-tambahan-Seller/main/add-ssh-user.sh" && chmod +x /usr/local/bin/add-ssh-user

#add user shadowsocks
wget -O /usr/local/bin/add-shadowsocks-user "https://raw.githubusercontent.com/hidessh99/Package-tambahan-Seller/main/hide/add-shadowsocks-user.sh" && chmod +x /usr/local/bin/add-shadowsocks-user
#add user trojan
wget -O /usr/local/bin/add-trojango-user "https://raw.githubusercontent.com/hidessh99/Package-tambahan-Seller/main/hide/add-trojango-user.sh" && chmod +x /usr/local/bin/add-trojango-user
#add user v2ray
wget -O /usr/local/bin/add-v2ray-user "https://raw.githubusercontent.com/hidessh99/Package-tambahan-Seller/main/hide/add-v2ray-user.sh" && chmod +x /usr/local/bin/add-v2ray-user

#delete user tojan
wget -O /usr/local/bin/del-trojango-user "https://raw.githubusercontent.com/hidessh99/Package-tambahan-Seller/main/hide/del-trojango-user.sh" && chmod +x /usr/local/bin/del-trojango-user
#delete user v2ray
wget -O /usr/local/bin/del-v2ray-user "https://raw.githubusercontent.com/hidessh99/Package-tambahan-Seller/main/hide/del-v2ray-user.sh" && chmod +x /usr/local/bin/del-v2ray-user
#delete user shadowsocks
wget -O /usr/local/bin/trvmss-del-exp "https://raw.githubusercontent.com/hidessh99/Package-tambahan-Seller/main/hide/trvmss-del-exp.sh" && chmod +x /usr/local/bin/trvmss-del-exp