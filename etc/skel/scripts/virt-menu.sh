#!/bin/bash
echo "macos"
echo "windows"
read -p "shutdown which?> " choice

case $choice in 
    macos)
        sudo virsh destroy macOS
	pkill cmatrix
	pkill synergy
        ;;
    windows)
        sudo virsh destroy win10
	pkill bashtop
	pkill barrier
        ;;
    *)
        echo "Sorry, invalid input"
esac
