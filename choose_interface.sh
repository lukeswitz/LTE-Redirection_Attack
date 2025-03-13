#!/bin/bash
#
# Copyright 2025  by Bastien Baranoff
#
kconfig-mconf run_menu
sed -i -e '/^#/d' .config
sed -i -e 's/CONFIG_//g' .config
sed -i -e 's/=y//g' .config
cp .config osmo_egprs/configs/operator
cp .config redirect_4_2g/scripts/operator
cp .config scripts/operator
cp .config operator
