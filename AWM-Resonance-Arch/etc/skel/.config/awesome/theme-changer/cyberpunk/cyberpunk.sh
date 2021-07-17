#!/bin/bash

pkill -f background

background auto /usr/share/gif/inspace.gif &

cp -r /home/$USER/.config/awesome/theme-changer/cyberpunk/.local /home/$USER/
