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
alias upload='cd ~/portafolio && git add . && git commit -m "update" && git push origin main'

# Asegurar que tus scripts funcionen
export PATH="$HOME/.local/bin:$PATH"
