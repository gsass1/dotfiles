# Path to your oh-my-zsh installation.
export ZSH="/home/nuke/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

plugins=(git)

source $ZSH/oh-my-zsh.sh

export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.rbenv/bin
export PATH=$PATH:$HOME/.rbenv/shims

export EDITOR=nvim

alias gs="git status"
alias gc="git commit"
alias gch="git checkout"
alias gb="git branch"
alias gd="git diff"

eval "$(rbenv init -)"
alias vim=nvim
alias cat=bat

alias xc=xclip -selection clipboard

export PATH=$PATH:/usr/local/go/bin

prompt_context(){}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
