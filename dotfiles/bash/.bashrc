#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1="\[\e[35m\]\u\[\e[34m\]@\h \[\e[36m\]\w\[\e[0m\]\$ "

# Alias para gestionar tus dotfiles rápido
alias dots='cd ~/portafolio'
alias desinc="cp -r ~/.config/{hypr,kitty,waybar,rofi,glava} ~/portafolio/dotfiles/ && cp ~/.bashrc ~/portafolio/dotfiles/bash/ && cd ~/portafolio && git add . && git commit -m 'Update completo: $(date +%D-%H:%M)' && git push origin main && cd -"
# Asegurar que tus scripts funcionen
export PATH="$HOME/.local/bin:$PATH"
