# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# function definitions.
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

# Environment definition.
if [ -f ~/.bash_environment ]; then
    . ~/.bash_environment
fi
