#!/bin/bash

# Colores para la terminal
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${CYAN}🚀 Iniciando instalación de My-Arch...${NC}"

# 1. Instalar yay (si no existe)
if ! command -v yay &> /dev/null; then
    echo -e "${YELLOW}➤ Instalando yay...${NC}"
    sudo pacman -S --needed base-devel git
    git clone https://aur.archlinux.org/yay.git
    cd yay && makepkg -si --noconfirm && cd ..
    rm -rf yay
fi

# 2. Instalar todas las dependencias
echo -e "${CYAN}➤ Instalando paquetes y estética...${NC}"
# He unido las listas para que sea una sola ejecución de yay
yay -S --needed --noconfirm \
    hyprland kitty waybar rofi calcurse glava micro \
    neofetch python-pywal sublime-text-4 otf-monocraft \
    hyprshot swww

# 3. Preparar directorios
echo -e "${CYAN}➤ Preparando directorios...${NC}"
mkdir -p ~/Pictures/wallpapers
mkdir -p ~/.config

# Corrigiendo el nombre de la carpeta de wallpapers (según tu repo es 'walpapers')
if [ -d "./walpapers" ]; then
    cp -rf ./walpapers/* ~/Pictures/wallpapers/
fi

# 4. Función Maestra para Enlaces Simbólicos (Symlinks)
# Esta función borra lo viejo y crea un enlace al repo
create_symlink() {
    local source_dir="$(pwd)/$1"
    local target_dir="$HOME/.config/$1"

    if [ -d "$source_dir" ]; then
        echo -e "${GREEN}🔗 Enlazando: $1${NC}"
        # Borra la carpeta o enlace viejo para evitar conflictos
        rm -rf "$target_dir"
        # Crea el enlace simbólico
        ln -s "$source_dir" "$target_dir"
    else
        echo -e "${YELLOW}⚠ Advertencia: No se encontró la carpeta $1 en el repo${NC}"
    fi
}

# Ejecutar la función para cada carpeta
configs=("hypr" "waybar" "kitty" "calcurse" "glava" "rofi")
for folder in "${configs[@]}"; do
    create_symlink "$folder"
done

# Caso especial para Sublime Text (ruta distinta)
echo -e "${GREEN}🔗 Enlazando: Sublime Text${NC}"
mkdir -p ~/.config/sublime-text/Packages/
rm -rf ~/.config/sublime-text/Packages/User
ln -s "$(pwd)/sublime" ~/.config/sublime-text/Packages/User

# 5. Configurar Scripts
echo -e "${CYAN}⚙️ Configurando scripts...${NC}"
chmod +x ./*.sh
# No los movemos a ~, los dejamos en el repo y si quieres los enlazas:
# ln -sf "$(pwd)/script.sh" ~/script.sh

# 6. Plugins de Hyprland
if command -v hyprpm &> /dev/null; then
    echo -e "${CYAN}➤ Activando plugins de Hyprland...${NC}"
    hyprpm add https://github.com/hyprwm/hyprland-plugins
    hyprpm enable hyprbar
    hyprpm reload
fi

echo -e "${GREEN}¡Sistema configurado con éxito!${NC}"
echo -e "${YELLOW}Nota: Ahora cualquier cambio en ~/.config/ se reflejará en este repo.${NC}"
