#!/bin/bash

# Este script usa NetworkManager (nmcli) para obtener el estado, la señal y simular las clases CSS dinámicas.

# Obtener el estado de conectividad (full, limited, none)
STATE=$(nmcli networking connectivity)

if [ "$STATE" == "full" ]; then
    # Conectado. Intentar obtener info de WiFi.
    WIFI_INFO=$(nmcli -t -f active,ssid,signal dev wifi | grep -E '^yes' | head -n 1)
    
    if [ -n "$WIFI_INFO" ]; then
        # Conectado a WiFi
        SSID=$(echo "$WIFI_INFO" | cut -d: -f2)
        SIGNAL=$(echo "$WIFI_INFO" | cut -d: -f3)
        # Devolvemos la clase "network-wifi"
        echo "{\"text\":\" ${SSID} (${SIGNAL}%)\", \"class\":\"network-wifi\"}"
    else
        # No hay WiFi activo, buscar Ethernet
        ETHERNET_INFO=$(nmcli -t -f device,state dev | grep -E 'ethernet:connected' | head -n 1)
        if [ -n "$ETHERNET_INFO" ]; then
            # Devolvemos la clase "network-ethernet"
            echo "{\"text\":\" Eth\", \"class\":\"network-ethernet\"}"
        else
            # Fallback (Conectado pero sin info clara)
            echo "{\"text\":\" UP\", \"class\":\"network-wifi\"}"
        fi
    fi
else
    # Desconectado (STATE es 'limited' o 'none')
    # Devolvemos la clase "disconnected"
    echo "{\"text\":\"⚠ Sin Red\", \"class\":\"disconnected\"}"
fi
