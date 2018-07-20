alias pf='pip freeze | grep -v "pkg-resources==0.0.0"'

alias sl='ls'
alias ll='ls --group-directories-first -lhF'
alias la='ls --group-directories-first -AF'

# some colour things
alias ls='ls --group-directories-first --color=auto -F'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Open multiple files as tabs
alias vim="vim -p"

alias setclip='xclip -selection c'
alias getclip='xclip -selection clipboard -o'

alias whatami='echo $TERM'

# git
alias gpom='git push origin master'
alias gd='git diff'
alias gits='git status'

alias pserv='python3 -m http.server'
alias svba='source venv/bin/activate'
# vagrant shit
alias vssh="vagrant ssh"
alias vp="vagrant provision"
alias vc="vagrant destroy -f && vagrant up --provision"
alias vd="vagrant destroy -f"
alias vgs="vagrant global-status"
alias vh="vagrant halt"

alias vimflake='vim $(flake8 | cut -d: -f 1 | uniq)'

# Docker
# Remove stopped containers and untagged images
alias dockerclean="docker rm \$(docker ps -a -q); docker rmi \$(docker images | grep \"^<none>\" | awk \"{print $3}\")"

alias lisp="rlwrap sbcl"