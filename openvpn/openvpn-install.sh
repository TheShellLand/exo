#!/bin/bash

# install.sh

# One script to rule them all
# and install openvpn



# Create tun device
cat > /etc/rc.local <<EOF
#!/bin/sh -e
#

cd /dev
mkdir net
mknod net/tun c 10 200
chmod 0666 net/tun

sysctl -w net.ipv4.ip_forward=1

su - root -c "/root/vpn-start.sh &"

exit 0
EOF

# OpenVPN autostart script
cat > /root/vpn-start.sh <<EOF
#!/bin/bash

# Restart openvpn on reboot


while true; do
        ps -ef| grep -v grep | grep /etc/openvpn/server.conf 2>/dev/null >/dev/null
        if [ ! "\$?" == 0 ]; then
                echo "[*] Restarting OpenVPN service..."
                service openvpn restart
                sleep 1
        else
                echo "[*] OpenVPN service running..."
                break
        fi
done
EOF

chmod +x /root/vpn-start.sh


# Install OpenVPN
apt update
apt install -y openvpn

# Set iptables
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
apt install -y iptables-persistent

# Set IPV4 forwarding
sysctl -w net.ipv4.ip_forward=1
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
sysctl -p

# Get OpenVPN easy-rsa
wget -O - https://github.com/OpenVPN/easy-rsa/releases/download/3.0.1/EasyRSA-3.0.1.tgz | tar zxf -
cd EasyRSA*
cp vars.example vars
./easyrsa init-pki
./easyrsa build-ca
./easyrsa gen-dh
openvpn --genkey --secret pki/ta.key
./easyrsa build-server-full server nopass


# Create server.conf
cat > /etc/openvpn/server.conf <<EOF
port 1194
proto udp
dev tun

key /root/EasyRSA-3.0.1/pki/private/server.key
ca /root/EasyRSA-3.0.1/pki/ca.crt
cert /root/EasyRSA-3.0.1/pki/issued/server.crt
dh /root/EasyRSA-3.0.1/pki/dh.pem
tls-auth /root/EasyRSA-3.0.1/pki/ta.key 0

server 10.8.0.0 255.255.255.0
ifconfig-pool-persist ipp.txt

push "redirect-gateway def1 bypass-dhcp"
push "dhcp-option DNS 8.8.8.8"
push "dhcp-option DNS 8.8.4.4"

keepalive 10 120
comp-lzo
user nobody
group nogroup
persist-key
persist-tun
status openvpn-status.log
verb 3
EOF


# Start OpenVPN service
service openvpn restart
