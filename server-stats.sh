#!/bin/bash

echo "Server Performance Stats Analysis"
echo "---------------------------------"

# Total CPU Usage
echo "CPU Usage:"
cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}')
echo "Total CPU Usage: $cpu_usage"

# Total Memory Usage
echo "Memory Usage:"
total_mem=$(free -m | awk '/^Mem:/ {print $2}')
used_mem=$(free -m | awk '/^Mem:/ {print $3}')
free_mem=$(free -m | awk '/^Mem:/ {print $4}')
mem_usage_percent=$(awk "BEGIN {printf \"%.2f\", ($used_mem / $total_mem) * 100}")
echo "Total Memory: ${total_mem}MB"
echo "Used Memory: ${used_mem}MB ($mem_usage_percent%)"
echo "Free Memory: ${free_mem}MB"

# Total Disk Usage
echo "Disk Usage:"
df_output=$(df -h --total | grep 'total')
total_disk=$(echo $df_output | awk '{print $2}')
used_disk=$(echo $df_output | awk '{print $3}')
free_disk=$(echo $df_output | awk '{print $4}')
disk_usage_percent=$(echo $df_output | awk '{print $5}')
echo "Total Disk: $total_disk"
echo "Used Disk: $used_disk ($disk_usage_percent)"
echo "Free Disk: $free_disk"

# Top 5 Processes by CPU Usage
echo "Top 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

# Top 5 Processes by Memory Usage
echo "Top 5 Processes by Memory Usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6

# Stretch Goals
echo "---------------------------------"
echo "Additional Server Information:"
# OS Version
os_version=$(lsb_release -d | awk -F"\t" '{print $2}')
echo "OS Version: $os_version"

# Uptime
echo "Uptime:"
uptime -p

# Load Average
echo "Load Average:"
uptime | awk -F'load average:' '{ print $2 }'

# Logged-in Users
echo "Logged-in Users:"
who | wc -l

# Failed Login Attempts
echo "Failed Login Attempts:"
grep "Failed password" /var/log/auth.log | wc -l

echo "---------------------------------"
echo "Server Performance Stats Collected."
