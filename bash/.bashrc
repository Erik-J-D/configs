# If not running interactively, don't do anything
[[ $- != *i* ]] && return

. ~/.bash_aliases
. ~/.bash_functions
. ~/.bash_environment

# Per computer extra settings
if [ -f ~/.bash_$HOSTNAME ]; then
    . ~/.bash_$HOSTNAME
fi
