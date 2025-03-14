sysctl -w net.ipv4.ip_forward=1
iptables -t nat -A POSTROUTING -o enp118s0 -j MASQUERADE
iptables -t nat -A POSTROUTING -o apn0 -j MASQUERADE
iptables -A FORWARD -i apn0 -o enp118s0 -j ACCEPT
iptables -A FORWARD -i ens33 -o apn0 -j ACCEPT
