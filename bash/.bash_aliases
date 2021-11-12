alias pf='pip freeze | grep -v "pkg-resources==0.0.0" | grep -v "ubuntu-drivers-common==0.0.0"'
alias o='xdg-open'
alias :q='exit'

alias sl='ls'
alias ll='ls --group-directories-first -lhF'
alias la='ls --group-directories-first -AF'

alias tree='tree -I "node_modules|venv"'

# some colour things
alias ls='ls --group-directories-first --color=auto -F'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ccat='pygmentize -g -O style=colorful,linenos=1'

# Open multiple files as tabs
alias vim='nvim -p'

alias setclip='xclip -selection c'
alias getclip='xclip -selection clipboard -o'

alias whatami='echo $TERM'

# git
alias gpom='git push origin master'
alias gd='git diff'
alias gits='git status'

alias pserv='python3 -m http.server'
alias svba='source venv/bin/activate'

alias vimflake='vim $(flake8 | cut -d: -f 1 | uniq)'

# screen brightness
# usage:   brightness 0.75    # where the number is between 0 and 1
alias brightness='xrandr --output `xrandr | grep " connected" | cut -f1 -d " " | grep "^e" | head -1` --brightness'

alias weather="clear; printf %b '\e]11;#778\a'; curl wttr.in"
