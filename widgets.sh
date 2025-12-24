#!/bin/bash

# Variables
BAT_DIR="/sys/class/power_supply/BAT0"
CLIMA_FILE="/tmp/ttyclock_clima.txt"

# Inicializar clima
curl -s wttr.in/monterrey?format=1 > "$CLIMA_FILE" &

# Hilo para actualizar clima cada 10 min
( while true; do
    curl -s wttr.in/monterrey?format=1 > "$CLIMA_FILE"
    sleep 600
done ) &

# Hilo para actualizar batería cada 30s
BAT_FILE="/tmp/ttyclock_bateria.txt"
( while true; do
    if [[ -d $BAT_DIR ]]; then
        CAP=$(cat $BAT_DIR/capacity)
        STATUS=$(cat $BAT_DIR/status)
        echo "$STATUS — $CAP%" > "$BAT_FILE"
    else
        echo "Batería no detectada" > "$BAT_FILE"
    fi
    sleep 30
done ) &

# Loop principal (hora grande estilo tty-clock)
while true; do
    clear
    # Hora grande con figlet
    HORA=$(date +"%H:%M:%S")
    figlet -f big "$HORA"

    # Mostrar batería y clima desde archivos temporales
    echo -e "🔋  $(cat $BAT_FILE)"
    echo -e "☁️   $(cat $CLIMA_FILE)"

    sleep 1
done
