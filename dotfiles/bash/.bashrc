#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1="\[\e[35m\]\u\[\e[34m\]@\h \[\e[36m\]\w\[\e[0m\]\$ "

