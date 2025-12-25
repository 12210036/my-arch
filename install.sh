#!/bin/bash

# --- Colores para una terminal con estilo ---
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${CYAN}🚀 Iniciando instalación de My-Arch...${NC}"

# 1. Instalación de yay (Helper de AUR)
if ! command -v yay &> /dev/null; then
    echo -e "${YELLOW}➤ Instalando yay...${NC}"
    sudo pacman -S --needed base-devel git
    git clone https://aur.archlinux.org/yay.git
    cd yay && makepkg -si --noconfirm && cd ..
    rm -rf yay
else
    echo -e "${GREEN}✔ yay ya está instalado.${NC}"
fi

# 2. Instalación de paquetes (Sistema, Editores y Estética)
echo -e "${CYAN}➤ Instalando paquetes necesarios...${NC}"
yay -S --needed --noconfirm \
    hyprland kitty waybar rofi calcurse glava micro \
    neofetch python-pywal sublime-text-4 otf-monocraft \
    hyprshot swww

# 3. Organización de Wallpapers
echo -e "${CYAN}➤ Configurando fondos de pantalla...${NC}"
mkdir -p ~/Pictures/wallpapers
if [ -d "./wallpapers" ]; then
    cp -rf ./wallpapers/* ~/Pictures/wallpapers/
    echo -e "${GREEN}✔ Wallpapers copiados a ~/Pictures/wallpapers${NC}"
fi

# 4. Función para Enlaces Simbólicos (Dotfiles)
create_symlink() {
    local source_dir="$(pwd)/dotfiles/$1"
    local target_dir="$HOME/.config/$1"

    if [ -d "$source_dir" ]; then
        echo -e "${GREEN}🔗 Enlazando: $1${NC}"
        rm -rf "$target_dir" # Evita conflictos
        ln -s "$source_dir" "$target_dir"
    else
        echo -e "${RED}⚠ No se encontró la carpeta $1 en dotfiles/${NC}"
    fi
}

echo -e "${CYAN}➤ Creando enlaces simbólicos para configuraciones...${NC}"
mkdir -p ~/.config
configs=("hypr" "waybar" "kitty" "calcurse" "glava" "rofi")
for folder in "${configs[@]}"; do
    create_symlink "$folder"
done

# Caso especial: Sublime Text
if [ -d "./dotfiles/sublime" ]; then
    echo -e "${GREEN}🔗 Enlazando: Sublime Text${NC}"
    mkdir -p ~/.config/sublime-text/Packages/
    rm -rf ~/.config/sublime-text/Packages/User
    ln -s "$(pwd)/dotfiles/sublime" ~/.config/sublime-text/Packages/User
fi

# 5. Instalación de Scripts Personales
echo -e "${CYAN}➤ Instalando scripts en ~/.local/bin...${NC}"
mkdir -p ~/.local/bin
if [ -d "./scripts" ]; then
    for script in ./scripts/*.sh; do
        if [ -f "$script" ]; then
            script_name=$(basename "$script")
            chmod +x "$script"
            # Crea el enlace quitando la extensión .sh para usarlo como comando
            ln -sf "$(pwd)/scripts/$script_name" "$HOME/.local/bin/${script_name%.sh}"
            echo -e "${GREEN}📜 Script instalado: ${script_name%.sh}${NC}"
        fi
    done
else
    echo -e "${YELLOW}⚠ No se encontró la carpeta 'scripts'. Saltando...${NC}"
fi

# 6. Plugins de Hyprland
if command -v hyprpm &> /dev/null; then
    echo -e "${CYAN}➤ Configurando plugins de Hyprland...${NC}"
    hyprpm add https://github.com/hyprwm/hyprland-plugins
    hyprpm enable hyprbar
    hyprpm reload
fi

echo -e "${CYAN}------------------------------------------${NC}"
echo -e "${GREEN}⭐ ¡Instalación completada con éxito!${NC}"
echo -e "${YELLOW}Nota: Asegúrate de que ~/.local/bin esté en tu PATH.${NC}"
echo -e "${CYAN}------------------------------------------${NC}"
