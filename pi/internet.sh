#!/bin/bash
sudo cp /media/joe/rootfs/etc/wpa_supplicant/wpa_supplicant.conf /media/joe/rootfs/etc/wpa_supplicant/wpa_supplicant.conf.old
sudo tee -a /media/joe/rootfs/etc/wpa_supplicant/wpa_supplicant.conf << EOF 

network={
    ssid="jonas"
    psk="openthedoor"
}
EOF
