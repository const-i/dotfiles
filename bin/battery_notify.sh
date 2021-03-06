#!/bin/sh

# Script to check the battery level and notify if it
# goes below a certain level
# NOTE: This needs to be executed periodically (1/min) via cron

LEVEL_NOTIFY=90
LEVEL_WARN=50
LEVEL_CRITICAL=20

BATTERY_LEVEL=$(cat /sys/class/power_supply/BAT1/capacity)
BATTERY_STATUS=$(cat /sys/class/power_supply/BAT1/status)

echo "Battery Level: $BATTERY_LEVEL"
echo "Battery status: $BATTERY_STATUS"


# If we have to notify we must export DBUS_SESSION_BUS_ADDRESS
# Source: https://askubuntu.com/questions/298608/notify-send-doesnt-work-from-crontab
# This is done by following: https://github.com/brambozz/dotfiles/blob/master/scripts/battery_cap_check
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
export DISPLAY=:0


[ -f "/home/srideep/bin/.battery_notify.tmp" ] && TMP_STATUS=$(cat /home/srideep/bin/.battery_notify.tmp) || TMP_STATUS=""


# If we are full then exit
if [ "$BATTERY_STATUS" = "Full" ]; then
    # Notify if we havent
    if [ "$TMP_STATUS" != "FULL" ]; then
        echo "FULL" > /home/srideep/bin/.battery_notify.tmp
        /usr/bin/notify-send "Battery Full" "Battery level: $BATTERY_LEVEL" --icon=battery-level-100-charged-symbolic.symbolic
    fi
    exit 0
fi

# Exit if we are charging
if [ "$BATTERY_STATUS" = "Charging" ]; then
    # Notify if we havent
    if [ "$TMP_STATUS" != "CHARGING" ]; then
        echo "CHARGING" > /home/srideep/bin/.battery_notify.tmp
        /usr/bin/notify-send "Battery Charging" "Battery level: $BATTERY_LEVEL" --icon=battery-level-50-charging-symbolic.symbolic
    fi
    exit 0
fi


# At this point the battery is not full or charging.
# Hence we notify based on the battery levels

# Critical Level
if [ $BATTERY_LEVEL -lt $LEVEL_CRITICAL ]; then
    if [ "$TMP_STATUS" != "CRITICAL" ]; then
        echo "CRITICAL" > /home/srideep/bin/.battery_notify.tmp
        /usr/bin/notify-send "Battery Level Critical" "Battery level: $BATTERY_LEVEL.\nShutting down in 5 mins" --icon=battery-level-10-symbolic.symbolic
        /usr/bin/shutdown +5
    fi
    exit 0
fi

# Warn level
if [ $BATTERY_LEVEL -lt $LEVEL_WARN ]; then
    if [ "$TMP_STATUS" != "WARN" ]; then
        echo "WARN" > /home/srideep/bin/.battery_notify.tmp
        /usr/bin/notify-send "Battery Level Warning" "Battery level: $BATTERY_LEVEL" --icon=battery-level-50-symbolic.symbolic
    fi
    exit 0
fi

# Notify level
if [ $BATTERY_LEVEL -lt $LEVEL_NOTIFY ]; then 
    if [ "$TMP_STATUS" != "NOTIFY" ]; then
        echo "NOTIFY" > /home/srideep/bin/.battery_notify.tmp
        /usr/bin/notify-send "Battery Level Notification" "Battery level: $BATTERY_LEVEL" --icon=battery-level-80-symbolic.symbolic
    fi
    exit 0
fi

