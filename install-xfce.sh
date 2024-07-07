#!/bin/bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y kali-desktop-xfce xrdp dbus-x11
echo "xfce4-session" > ~/.xsession
sudo /etc/init.d/xrdp start
