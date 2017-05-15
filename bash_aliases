alias sl='ls'

# some colour things
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ll='ls -l'
alias la='ls -A'

# Open multiple files as tabs
alias vim="vim -p"

alias setclip='xclip -selection c'
alias getclip='xclip -selection clipboard -o'

alias whatami='echo $TERM'

alias gpom='git push origin master'
alias gd='git diff'
alias gits='git status'

alias pserv='python3 -m http.server'

# vagrant shit
alias vssh="vagrant ssh"
alias vp="vagrant provision"
alias vc="vagrant destroy -f && vagrant up --provision"
alias vd="vagrant destroy -f"
alias vgs="vagrang global-status"
alias vh="vagrant halt"
