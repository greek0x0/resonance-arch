#!/bin/bash

pkill -f background

background auto /usr/share/gif/train.gif &

cp -r /home/$USER/.config/awesome/theme-changer/trains/.local /home/$USER/
