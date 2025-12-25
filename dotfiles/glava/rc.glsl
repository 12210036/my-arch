/* El módulo 'bars' es el que mejor queda con la estética de bloques */
#request mod bars

/* Window hints: Clave para que Hyprland lo maneje como un widget */
#request setfloating     true
#request setdecorated    false
#request setfocused      false
#request setmaximized    false

/* Opacidad nativa para que sea transparente */
#request setopacity "native"

/* No necesitamos espejo para un look limpio */
#request setmirror true

/* Configuración de shaders estándar */
#request setversion 3 3
#request setshaderversion 330

/* Título de la ventana (útil para las reglas de Hyprland) */
#request settitle "barritas"

/* Geometría: 
   Ajusta 1920 al ancho de tu monitor. 
   400 es la altura del visualizador en la parte inferior. */
#request setgeometry 0 0 1920 400

/* Fondo totalmente transparente (el último 00 es el canal alpha) */
#request setbg 00000000

/* El truco para Hyprland/Wayland: 
   Usamos "!" para que sea una ventana no gestionada (unmanaged) */
#request setxwintype "!"

/* Fuente de audio: auto usa el micrófono/salida por defecto de Pipewire/Pulse */
#request setsource "auto"

/* Sincronización y suavidad */
#request setswap 1
#request setinterpolate true
#request setframerate 0

/* Mejora el rendimiento */
#request setfullscreencheck true

/* Configuración de procesamiento de audio */
#request setsamplesize 1024
#request setbufsize 4096
#request setsamplerate 22050
