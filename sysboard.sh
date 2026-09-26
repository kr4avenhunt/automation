#!/bin/bash

source /etc/os-release # Importing the file with the OS infos

# <--- Declaring the colors --->
RESET="\e[0m"
BOLD="\e[1m"		# Title Colors
BG_BLUE="\033[44m"
BG_LIGHT_BLUE="\033[104m"
# ----------------
GREEN="\e[32m"
RED="\e[31m"   		# Monitoring Colors
YELLOW="\e[33m"
# ----------------
BLUE="\033[0;34m"	# Main Colors
LIGHT_BLUE="\033[94m"
# ----------------

echo ""
# <--- Title Device Name--->
DEVICENAME="${USER}@$(uname -n)"
len_device=${#DEVICENAME}
echo -e "${BOLD}${BG_BLUE}$DEVICENAME${RESET}"
printf "%${len_device}s\n" | tr ' ' '-' # Print as many - as the DeviceName

# <--- System Infos --->
echo -e "${BLUE}OS:${RESET} ${PRETTY_NAME}"
echo -e "${BLUE}Shell:${RESET} $(basename $SHELL) ${BASH_VERSION}"

cpu=$(lscpu | grep "Model name: " | cut -d ':' -f2 | sed 's/^[ \t]*//')
echo -e "${BLUE}CPU:${RESET} ${cpu}"

gpu=$(lspci | grep -i "vga\|3d" | sed 's/.*://' | sed 's/^[ \t]*//')
echo -e "${BLUE}GPU:${RESET} ${gpu}"

# <--- Title Hardware Monitoring --->
len_gpu=$((${#gpu} + 5))
printf "%${len_gpu}s\n" | tr ' ' '-'
echo -e "${BOLD}${BG_LIGHT_BLUE}SYSTEM MONITORING${RESET}"
echo "-----------------"
# -----------------------------------

# Reading The CPU usage from /proc/stat file
read -r cpu user nice system idle iowait irq siftirq steal _ < /proc/stat
idle1=$((idle + iowait))
total1=$((user + nice + system + idle + iowait + irq + softirq + steal))

sleep 0.5

read -r cpu user nice system idle iowait irq siftirq steal _ < /proc/stat
idle2=$((idle + iowait))
total2=$((user + nice + system + idle + iowait + irq + softirq + steal))

diff_idle=$((idle2 - idle1))
diff_total=$((total2 - total1))

# Calculating the CPU usage and building the bar
cpu_usage=$(awk "BEGIN{ printf \"%.2f\", (1- $diff_idle / $diff_total) * 100}")
full=$(echo "$cpu_usage / 10" | bc)
empty=$((10 - full))
cpu_bar=""
for ((i=0; i<full; i++)); do cpu_bar="${cpu_bar}█"; done
for ((i=0; i<empty; i++)); do cpu_bar="${cpu_bar}░"; done
echo -e "${LIGHT_BLUE}CPU:${RESET} ${cpu_bar} ${cpu_usage}%"





















