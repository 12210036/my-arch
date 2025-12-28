/* 1. IMPORTACIÓN DE COLORES (Pywal) */
/* Esto debe ir al principio para que los módulos reconozcan las variables */
#include "pywal_colors.glsl"
/* 2. SOLICITUD DE MÓDULO */
#request mod bars

/* 3. CONFIGURACIÓN DE VENTANA (Optimizado para Hyprland) */
#request setfloating     false
#request setdecorated    true
#request setfocused      false
#request setmaximized    false
#request setopacity      "native"
#request settitle        "barritas"

/* Geometría: En la parte inferior de un monitor 1080p */
/* Transparencia total del fondo */
#request setbg 00000000

/* El "!" es vital para que Wayland/Hyprland no intente mover la ventana */
#request setxwintype "!"

/* 4. RENDERIZADO Y AUDIO */
#request setsource "auto"
#request setmirror true
#request setversion 3 3
#request setshaderversion 330
#request setswap 1
#request setinterpolate true
#request setframerate 0
#request setfullscreencheck true
#request setsamplesize 1024
#request setbufsize 4096
#request setsamplerate 22050
