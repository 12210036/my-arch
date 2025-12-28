#!/bin/bash

# 1. Selecciona un fondo al azar
WALL=$(find ~/walpaper -type f | shuf -n 1)

# 2. Cambia el fondo con efecto
swww img "$WALL" --transition-type grow

# 3. Genera los colores con Pywal
wal -i "$WALL" -q

# 4. REINICIAR GLAVA (Para que cargue los nuevos bloques)
pkill glava
glava --desktop &

# 5. REFRESCAR KITTY (Cambio de color instantáneo)
# Esto envía una señal a todas las terminales abiertas
if [ -S /tmp/mykitty ]; then
    kitty @ --allow-remote-control set-colors -a -c ~/.cache/wal/colors-kitty.conf
fi

# 6. REFRESCAR WAYBAR
killall -SIGUSR2 waybar

# 7. NOTIFICACIÓN (Opcional, estilo Minecraft)
notify-send "Estilo Actualizado" "Bioma cambiado: $(basename "$WALL")" -i "$WALL"
