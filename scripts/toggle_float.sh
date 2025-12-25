#!/bin/bash
# Obtiene el estado actual de la ventana
STATE=$(hyprctl activewindow -j | jq -r ".floating")

if [ "$STATE" = "true" ]; then
    # Si es flotante, la regresa a modo normal
    hyprctl dispatch togglefloating
    notify-send "Ventana Acoplada" -i "minecraft_block" # Opcional
else
    # Si es normal, la hace flotar y la centra
    hyprctl dispatch togglefloating
    hyprctl dispatch centerwindow
fi
