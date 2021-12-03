# If not running interactively, don't do anything
[[ $- != *i* ]] && return

. ~/.zsh_aliases
. ~/.zsh_functions
. ~/.zsh_environment

# Per computer extra settings
if [ -f ~/.zsh_$HOST ]; then
    . ~/.zsh_$HOST
fi
