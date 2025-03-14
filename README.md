# LTE-Redirection_Attack
Force target victim to unsafe network

## Build

```bash
sudo ./build.sh
```


## Run

```bash
sudo ./run.sh
```

2G EGPRS Fake base Station :

Change if not in osmocom terminal osmo-bsc.cfg remote ip 192.168.1.23 par l'ip de votre interface internet : remote ip 192.168.X.X
Change in osmo-sgsn.cfg bind udp local, listen 192.168.1.23 by yours

In Osmocom Popped Terminal (change MCC//MNC accordingly in osmo-bsc.cfg osmo-bsc.cfg)

```bash
./runme.sh
osmo-trx-uhd
```

Forward your ip in host terminal:
```bash
./srsepc_if_masq.sh your_interface
```


LTE Node redirector

```bash
write mcc (replace)
write mnc (relace)
wirte tracking_area_code (replace)
write mcc (replace)
write mnc (replace)
write band (replace)
write dl_earfcn (replace)
write tx_gain 80
write rx_gain 30
start
``` 
