#!/bin/zsh


echo Date: "\t\t\t" "$(date +%F\ %X)"
echo Battery Capacity: "\t" "$(cat /sys/class/power_supply/BAT1/capacity)"
echo Battery Status: "\t" "$(cat /sys/class/power_supply/BAT1/status)"
echo Wifi SSID: "\t\t" "$(nmcli -t -f NAME connection show --active)"
