#!/bin/bash

echo "=================================="
echo "      SERVER PERFORMANCE STATS"
echo "=================================="
echo ""

echo "DATE: $(date)"
echo ""

echo "OS VERSION:"
grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"'
echo ""
echo "UPTIME:"
uptime -p
echo ""

cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}' | cut -d. -f1)

cpu_usage=$((100 - cpu_idle))

echo "CPU Usage: $cpu_usage%"
echo ""

echo "MEMORY USAGE:"

mem_total=$(free -m | awk '/Mem:/ {print $2}')
mem_used=$(free -m | awk '/Mem:/ {print $3}')
mem_free=$(free -m | awk '/Mem:/ {print $4}')

mem_percent=$((100 * mem_used / mem_total))

echo "Total: ${mem_total}MB"
echo "Used: ${mem_used}MB"
echo "Free: ${mem_free}MB"
echo "Usage: ${mem_percent}%"
echo ""

echo "DISK USAGE:"

disk_total=$(df -h / | awk 'NR==2 {print $2}')
disk_used=$(df -h / | awk 'NR==2 {print $3}')
disk_free=$(df -h / | awk 'NR==2 {print $4}')
disk_percent=$(df -h / | awk 'NR==2 {print $5}')

echo "Total: $disk_total"
echo "Used: $disk_used"
echo "Free: $disk_free"
echo "Usage: $disk_percent"
echo ""


echo "TOP 5 PROCESSES BY CPU USAGE:"

ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6

echo ""

echo "TOP 5 PROCESSES BY MEMORY USAGE:"

ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6

echo ""
