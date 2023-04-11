#!/bin/bash

# Funkce pro získání aktuálního času v UNIX timestamp
get_time() {
    date +%s
}

# Funkce pro získání využití CPU v procentech
get_cpu_usage() {
    top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}' | awk '{printf "%.2f", $0}'
}

# Funkce pro získání využití paměti
get_memory_usage() {
    used=$(free | grep Mem | awk '{print $3}')
    total=$(free | grep Mem | awk '{print $2}')
    used_mb=$(echo "scale=0; $used/1024" | bc)
    total_mb=$(echo "scale=0; $total/1024" | bc)
    echo "$used_mb MB out of $total_mb MB"
}

# Vytvoření souboru usage.log, pokud neexistuje
touch usage.log

# Hlavní smyčka, která opakovaně volá funkce pro získání informací a ukládá je do souboru na nový řádek
while true
do
    # Získání informací o čase, využití CPU a paměti v UNIX timestamp
    time=$(get_time)
    cpu=$(get_cpu_usage)
    memory=$(get_memory_usage)

    # Uložení informací do souboru na nový řádek
    echo "$time CPU: $cpu% Memory: $memory" >> usage.log

    # Přestávka 1 minuta
    sleep 60
done
