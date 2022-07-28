# If not running interactively, don't do anything
[[ $- != *i* ]] && return

. ~/.zsh_aliases
. ~/.zsh_functions
. ~/.zsh_environment

# Per computer extra settings
test -e "${HOME}/.zsh_${HOST}" && source "${HOME}/.zsh_${HOST}"
