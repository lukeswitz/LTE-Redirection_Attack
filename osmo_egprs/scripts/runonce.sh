sed -i -e 's/network-online.target/nss-lookup.target/g' /lib/systemd/system/osmo-*.service
sed -i -e 's/ser=osmocom/ser=root/g' /lib/systemd/system/osmo-*.service
sed -i -e 's/oup=osmocom/oup=root/g' /lib/systemd/system/osmo-*.service
systemctl daemon-reload
./osmo-all.sh stop
./osmo-all.sh start

