#!/bin/bash

# Funkce pro získání aktuálního času v UNIX timestamp
get_time() {
    date +%s
}

# Funkce pro získání využití CPU v procentech
get_cpu_usage() {
    top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}' | awk '{printf "%.2f", $0}'
}

get_memory_usage() {
    used=$(free | grep Mem | awk '{print $3}')
    total=$(free | grep Mem | awk '{print $2}')
    echo "$(echo "scale=0; $used/$total*100" | bc)%"
}
touch usage.log

while true
do
    time=$(get_time)
    cpu=$(get_cpu_usage)
    memory=$(get_memory_usage)

    echo "$time CPU: $cpu% Memory: $memory" >> usage.log

    sleep 60
done
