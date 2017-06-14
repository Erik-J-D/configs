# Set PS1
function color_my_prompt {
    local __last_command_health='$(if [[ $? == 0 ]]; then echo "\[\033[01;32m\]✓"; else echo "\[\033[31m\]✗"; fi)'
    local __user_and_host="\[\033[01;32m\]\u@\h"
    local __cur_location="\[\033[01;34m\]\w"
    local __git_branch_color="\[\033[31m\]"
    local __git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`'
    local __prompt_tail="\[\033[35m\]⌬"
    local __last_color="\[\033[00m\]"
    export PS1="$__last_command_health $__user_and_host $__cur_location $__git_branch_color$__git_branch\n$__prompt_tail$__last_color "
    export PS2="$__prompt_tail $__last_color "
}
color_my_prompt

# cd then ls
function cl() { cd "$@" && ls; }

# brightness control for laptop
function brightness() { echo -n "$@" > /sys/class/backlight/intel_backlight/brightness; }

# remove .pyc, .pyo, pycache
function pyclean () {
    find . -type f -name "*.py[co]" -delete
    find . -type d -name "__pycache__" -delete
}
