#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Please run the script with sudo."
  exit
fi

echo "Checking for figlet installation..."
if ! command -v figlet &> /dev/null
then
    echo "Figlet is not installed. Installing figlet..."
    sudo apt-get update -y
    sudo apt-get install figlet -y
fi

figlet -f standard "ANOM Optimizer"

echo -ne 'Setting up environment: [#                  ] (5%)\r'
sleep 1
echo -ne 'Setting up environment: [###                ] (10%)\r'
sleep 1
echo -ne 'Setting up environment: [#####              ] (20%)\r'
sleep 1
echo -ne 'Setting up environment: [#######            ] (35%)\r'
sleep 1
echo -ne 'Setting up environment: [#########          ] (50%)\r'
sleep 1
echo -ne 'Setting up environment: [#############      ] (70%)\r'
sleep 1
echo -ne 'Setting up environment: [###############    ] (85%)\r'
sleep 1
echo -ne 'Setting up environment: [###################] (100%)\r'
echo -ne '\n'

echo "Adding settings to /etc/security/limits.conf..."
echo -e "\n* soft nofile 51200\n* hard nofile 51200" >> /etc/security/limits.conf

echo "Setting ulimit..."
ulimit -n 51200

echo "Adding settings to /etc/ufw/sysctl.conf..."
echo -e "\nfs.file-max = 51200\nnet.core.rmem_max = 67108864\nnet.core.wmem_max = 67108864\nnet.core.netdev_max_backlog = 250000\nnet.core.somaxconn = 4096\nnet.ipv4.tcp_syncookies = 1\nnet.ipv4.tcp_tw_reuse = 1\nnet.ipv4.tcp_tw_recycle = 0\nnet.ipv4.tcp_fin_timeout = 30\nnet.ipv4.tcp_keepalive_time = 1200\nnet.ipv4.ip_local_port_range = 10000 65000\nnet.ipv4.tcp_max_syn_backlog = 8192\nnet.ipv4.tcp_max_tw_buckets = 5000\nnet.ipv4.tcp_fastopen = 3\nnet.ipv4.tcp_mem = 25600 51200 102400\nnet.ipv4.tcp_rmem = 4096 87380 67108864\nnet.ipv4.tcp_wmem = 4096 65536 67108864\nnet.ipv4.tcp_mtu_probing = 1\nnet.ipv4.tcp_congestion_control = hybla" >> /etc/ufw/sysctl.conf

echo "Reloading sysctl settings..."
sysctl -p /etc/ufw/sysctl.conf

echo "Good Luck!"

echo
echo "t.me/MemoryOfNaengi" | awk '{printf("%*s\n", (50+length)/2, $0)}'
echo "github.com/ThisisANOM" | awk '{printf("%*s\n", (50+length)/2, $0)}'
echo
