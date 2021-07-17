#!/bin/bash


sudo mount /dev/sda1 /home/greek/media/iso
sudo virsh start macOS
barrierc -f --debug NOTE --daemon --name arch --enable-crypto 192.168.122.185:24800
cmatrix
