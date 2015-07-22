export EDITOR=vim

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# Bash completion
if [ -f /usr/share/bash_completion ]; then
. /usr/share/bash_completion
fi

if [ -f /usr/share/git/completion/git-prompt.sh ]; then
    source /usr/share/git/completion/git-prompt.sh
else
    if [ -f /etc/bash_completion.d/git-prompt ]; then
    source /etc/bash_completion.d/git-prompt
    fi
fi

source .git-prompt.sh
source "$HOME/.rvm/scripts/rvm"

export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w\[\033[01;33m\]$(__git_ps1)\[\033[01;34m\] \$\[\033[00m\] '

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
