#!/bin/bash

# --- Colores para la terminal ---
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

REPO_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo -e "${CYAN}Iniciando Instalación de My-Arch Setup...${NC}"

# 1. INSTALACIÓN DE DEPENDENCIAS (PACMAN)
echo -e "${CYAN}Instalando programas desde repositorios oficiales...${NC}"
PROGRAMAS=(
    "hyprland" "kitty" "waybar" "rofi-wayland" 
    "calcurse" "glava" "micro" "swww" 
    "python-pywal" "grim" "slurp" "hyprshot" "spotify" "firefox"
)

for proga in "${PROGRAMAS[@]}"; do
    if pacman -Qi "$proga" &> /dev/null; then
        echo -e "${GREEN}✔ $proga ya está instalado.${NC}"
    else
        echo -e "${YELLOW}Installing $proga...${NC}"
        sudo pacman -S --needed --noconfirm "$proga"
    fi
done

# 2. CREACIÓN DE DIRECTORIOS
echo -e "${CYAN}Preparando carpetas en ~/.config...${NC}"
mkdir -p ~/.config/{hypr,waybar,kitty,calcurse,glava,rofi}
mkdir -p ~/.local/bin
mkdir -p ~/Pictures/wallpapers

# 3. INSTALACIÓN DE CONFIGURACIONES (DOTFILES)
# Usamos copia física para que el sistema sea independiente del repo
echo -e "${CYAN}⚙️  Copiando archivos de configuración...${NC}"

# Función para copiar con seguridad
copy_config() {
    local dir=$1
    if [ -d "$REPO_PATH/dotfiles/$dir" ]; then
        cp -rf "$REPO_PATH/dotfiles/$dir"/* "$HOME/.config/$dir/"
        echo -e "${GREEN}✔ Config de $dir instalada.${NC}"
    else
        echo -e "${RED}✘ Error: No se encontró la carpeta dotfiles/$dir en el repo.${NC}"
    fi
}

copy_config "hypr"
copy_config "waybar"
copy_config "kitty"
copy_config "calcurse"
copy_config "glava"
copy_config "rofi"

# 4. INSTALACIÓN DE SCRIPTS PERSONALES
echo -e "${CYAN}📜 Instalando y dando permisos a los scripts...${NC}"
if [ -d "$REPO_PATH/scripts" ]; then
    # Dar permisos de ejecución a todos los scripts
    chmod +x "$REPO_PATH/scripts"/*.sh
    # Copiar a ~/.local/bin para que se puedan ejecutar como comandos
    cp -rf "$REPO_PATH/scripts"/*.sh ~/.local/bin/
    # También dejar copias en el Home como especificaste
    cp -rf "$REPO_PATH/scripts"/*.sh ~/
    echo -e "${GREEN}✔ Scripts instalados en ~/.local/bin y ~/${NC}"
else
    echo -e "${RED}✘ Error: No se encontró la carpeta scripts/.${NC}"
fi

# 5. WALLPAPERS
echo -e "${CYAN}🖼  Copiando wallpapers...${NC}"
if [ -d "$REPO_PATH/wallpaper" ]; then
    cp -rf "$REPO_PATH/wallpaper"/* ~/Pictures/wallpapers/
    echo -e "${GREEN}✔ Wallpapers listos.${NC}"
fi

# 6. CONFIGURACIÓN DE BASH
if [ -f "$REPO_PATH/dotfiles/bash/.bashrc" ]; then
    cp -f "$REPO_PATH/dotfiles/bash/.bashrc" "$HOME/.bashrc"
    echo -e "${GREEN}✔ .bashrc actualizado.${NC}"
fi
# --- Sección específica para Sublime Text ---
echo -e "${CYAN}💻 Configurando Sublime Text 4...${NC}"
SUBLIME_TARGET="$HOME/.config/sublime-text-3/Packages/User"

if [ -d "$REPO_PATH/sublime" ]; then
    # Crear la ruta por si no existe
    mkdir -p "$SUBLIME_TARGET"
    # Copiar solo el contenido de tu carpeta sublime/ a la carpeta User de Sublime
    cp -rf "$REPO_PATH/sublime"/* "$SUBLIME_TARGET/"
    echo -e "${GREEN}✔ Configuración de Sublime Text instalada en Packages/User.${NC}"
else
    echo -e "${RED}✘ Error: No se encontró la carpeta sublime/ en el repo.${NC}"
fi
# 7. NOTA FINAL SOBRE GLAVA Y PYWAL
echo -e "${YELLOW}⚠️  Nota: Para que Glava use tus colores de Pywal, recuerda ejecutar:${NC}"
echo -e "${CYAN}ln -sf ~/.cache/wal/glava.glsl ~/.config/glava/pywal_colors.glsl${NC}"

echo -e "${CYAN}------------------------------------------${NC}"
echo -e "${GREEN}✅ ¡Setup instalado exitosamente!${NC}"
echo -e "${YELLOW}Reinicia Hyprland o ejecuta 'source ~/.bashrc' para empezar.${NC}"
