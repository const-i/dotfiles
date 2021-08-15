echo
echo 
echo "Disabling WiFi"
echo "=============="
echo

ip link set wlp2s0 up


echo
echo
echo "Setting CPU Frequency"
echo "====================="
echo

cpupower frequency-set -g powersave

echo
echo
echo "Setting Swappiness"
echo "=================="
echo

sysctl -w vm.swappiness=60

echo
echo
echo "Running realTimeConfigQuickScan"
echo "==============================="
echo

sudo -H -u srideep SOUND_CARD_IRQ=23 /usr/bin/perl /home/srideep/projects/git/realtimeconfigquickscan/realTimeConfigQuickScan.pl

echo
echo
echo "Checking CPU Frequency Info"
echo "==========================="
echo

cpupower frequency-info

echo
echo
echo "Done!"
echo "====="
echo

