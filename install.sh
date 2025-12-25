#!/bin/bash

# --- Colores ---
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Obtener la ruta absoluta de donde está el script instalado
# Esto evita que los enlaces se rompan si ejecutas el script desde otra carpeta
REPO_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo -e "${CYAN}🚀 Asegurando configuración de My-Arch...${NC}"

# 1. Función para crear Enlaces Simbólicos (Dotfiles)
# Esta versión es más robusta: borra lo viejo y enlaza a la nueva carpeta 'dotfiles'
create_symlink() {
    local folder_name=$1
    local source="$REPO_PATH/dotfiles/$folder_name"
    local target="$HOME/.config/$folder_name"

    if [ -d "$source" ]; then
        echo -e "${GREEN}🔗 Enlazando .config/$folder_name...${NC}"
        rm -rf "$target" # Borra carpeta o enlace roto previo
        ln -s "$source" "$target"
    else
        echo -e "${YELLOW}⚠ Carpeta $folder_name no encontrada en dotfiles/, saltando...${NC}"
    fi
}

# 2. Ejecutar enlaces de carpetas en .config
mkdir -p ~/.config
configs=("hypr" "waybar" "kitty" "calcurse" "glava" "rofi")
for folder in "${configs[@]}"; do
    create_symlink "$folder"
done

# 3. Reglas Especiales (Archivos que NO van en .config)
echo -e "${CYAN}➤ Configurando archivos de inicio (Bash)...${NC}"
if [ -f "$REPO_PATH/dotfiles/bash/.bashrc" ]; then
    rm -f "$HOME/.bashrc"
    ln -s "$REPO_PATH/dotfiles/bash/.bashrc" "$HOME/.bashrc"
    echo -e "${GREEN}🔗 .bashrc enlazado.${NC}"
fi

# 4. Enlaces de Scripts Personales
echo -e "${CYAN}➤ Enlazando scripts a ~/.local/bin...${NC}"
mkdir -p ~/.local/bin
if [ -d "$REPO_PATH/scripts" ]; then
    for script in "$REPO_PATH/scripts"/*.sh; do
        if [ -f "$script" ]; then
            name=$(basename "$script")
            chmod +x "$script"
            # Enlaza sin la extensión .sh para que sea un comando limpio
            ln -sf "$script" "$HOME/.local/bin/${name%.sh}"
            echo -e "${GREEN}📜 Comando '${name%.sh}' listo.${NC}"
        fi
    done
fi

# 5. Wallpapers (Copia, no enlace, para evitar que pywal se confunda)
echo -e "${CYAN}➤ Actualizando wallpapers...${NC}"
mkdir -p ~/Pictures/wallpapers
if [ -d "$REPO_PATH/wallpaper" ]; then
    cp -rf "$REPO_PATH/wallpaper"/* ~/Pictures/wallpapers/
    echo -e "${GREEN}✔ Wallpapers listos en ~/Pictures/wallpapers${NC}"
fi

echo -e "${CYAN}------------------------------------------${NC}"
echo -e "${GREEN}✅ ¡Todo arreglado y sincronizado!${NC}"
echo -e "${YELLOW}Recuerda: Si mueves la carpeta '$REPO_PATH', deberás correr el script de nuevo.${NC}"
