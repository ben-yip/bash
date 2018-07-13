#!/usr/bin/env bash

# get shadowsocks in python version
mkdir /temp
cd /temp
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py
pip install shadowsocks

# settle shadowsocks config file in JSON
cat << EOF > /etc/ssconfig.json
{
    "server":"0.0.0.0",
    "server_port":8105,
    "local_port":1080,
    "password":"asdf2345..",
    "timeout":600,
    "method":"aes-256-cfb"
}
EOF

# turndown firewall
systemctl stop firewalld

# start shadowsocks server
ssserver -c /etc/ssconfig.json -d start
