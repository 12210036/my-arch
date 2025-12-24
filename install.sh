#!/bin/bash
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}Iniciando instalación completa...${NC}"

# 1. Instalar yay (si no existe) para manejar AUR (Sublime, Pywal, etc)
if ! command -v yay &> /dev/null; then
    echo -e "${CYAN} Instalando yay...${NC}"
    sudo pacman -S --needed base-devel git
    git clone https://aur.archlinux.org/yay.git
    cd yay && makepkg -si && cd ..
    rm -rf yay
fi

# 2. Instalar todas las dependencias
echo -e "${CYAN} Instalando programas de sistema, editores y estética...${NC}"
# En la sección de instalación de paquetes de tu install.sh
yay -S --needed hyprland kitty waybar rofi calcurse glava micro \
neofetch python-pywal sublime-text-4 otf-monocraft hyprshot

# Añade swww a la lista de instalación de yay
yay -S --needed swww

# Crea la carpeta de fondos en el sistema y los copia
mkdir -p ~/Pictures/wallpapers
cp -rf ./walpapers/* ~/walpapers/

# 3. Crear carpetas y copiar configuraciones
echo -e "${CYAN}Restaurando configuraciones (.config)...${NC}"
mkdir -p ~/.config/{hypr,waybar,kitty,calcurse,glava,rofi,sublime-text/Packages/User}

cp -rf ./hypr/* ~/.config/hypr/
cp -rf ./waybar/* ~/.config/waybar/
cp -rf ./kitty/* ~/.config/kitty/
cp -rf ./calcurse/* ~/.config/calcurse/
cp -rf ./glava/* ~/.config/glava/
cp -rf ./rofi/* ~/.config/rofi/
cp -rf ./sublime/* ~/.config/sublime-text/Packages/User/

# 4. Configurar Scripts
echo -e "${CYAN}⚙️ Configurando scripts...${NC}"
cp -rf ./*.sh ~/
chmod +x ~/*.sh
chmod +x ./install.sh

# 5. Plugins de Hyprland
echo -e "${CYAN}Activando plugins...${NC}"
hyprpm add https://github.com/hyprwm/hyprland-plugins
hyprpm enable hyprbar
hyprpm reload

echo -e "${CYAN}¡Sistema restaurado!${NC}"
