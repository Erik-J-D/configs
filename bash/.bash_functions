# Set PS1
function color_my_prompt {
    local __last_command_health='$(if [[ $? == 0 ]]; then echo "\[\033[01;32m\]✓"; else echo "\[\033[01;31m\]✗"; fi)'
    local __user_and_host='$(if [[ -n $SSH_CLIENT ]]; then echo "\[\033[01;31m\]\u@\h"; else echo "\[\033[01;34m\]\u@\h"; fi)'
    local __cur_location="\[\033[01;32m\]\w"
    local __git_branch_color="\[\033[33m\]"
    local __git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)/`'
    local __prompt_tail="\[\033[01;35m\]$"
    local __last_color="\[\033[00m\]"
    export PS1="$__last_command_health $__user_and_host $__cur_location $__git_branch_color$__git_branch\n$__prompt_tail$__last_color "
    export PS2="$__prompt_tail $__last_color "
}
color_my_prompt

# cd then ls
function cl() { cd "$@" && ls; }

function viewmd() {
    pandoc "$*" | lynx -stdin
    # grip "$*"
}

function vack() {
    vim $(ack -l "$@")
}

# remove .pyc, .pyo, caches
function pyclean () {
    find . -type f -name "*.py[co]" -delete
    find . -path '*/__pycache__/*' -delete
    find . -type d -name "__pycache__" -delete
    find . -path '*/.pytest_cache/*' -delete
    find . -type d -name ".pytest_cache" -delete
    find . -path '*/.mypy_cache/*' -delete
    find . -type d -name ".mypy_cache" -delete
}

function decrypt_pdf() {
    qpdf --decrypt --password="" $1 $2
}

function num_pages() {
    qpdf --show-npages $1 2> /dev/null
}
