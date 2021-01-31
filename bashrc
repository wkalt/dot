set -o vi
#
export HISTTIMEFORMAT="%m/%d/%y %T "
export TERM="screen-256color"
export EDITOR="vim"
export BROWSER="firefox"
export FACTERLIB=~/facter
export ANSIBLE_INVENTORY=~/ansible
export COLUMNS

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

## enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=always'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=always'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'

else
    export CLICOLOR=1
    export LSCOLORS=GxFxCxDxBxegedabagaced
fi

# some more ls aliases
alias ll='ls -alFrt'
alias la='ls -A'
alias l='ls -CF'
alias sl=ls


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

PS1="[\w] \`ruby -e \"print (%x{git branch 2> /dev/null}.match(/^\*.*/).to_s || '').gsub(/^\* (.+)$/, '(\1) ')\"\`$ "
#
if [ -n "$SSH_CONNECTION" ]; then
    PS1="\[\e[1;31m\][\u@\h \W]\`ruby -e \"print (%x{git branch 2> /dev/null}.match(/^\*.*/).to_s || '').gsub(/^\* (.+)$/, '(\1) ')\"\`$\[\e[0m\] "
fi

if [ "$(id -u)" == "0" ]; then
    PS1="\[\e[1;33m\][\u@\h \W]\`ruby -e \"print (%x{git branch 2> /dev/null}.match(/^\*.*/).to_s || '').gsub(/^\* (.+)$/, '(\1) ')\"\`$\[\e[0m\] "
fi


export GOPATH=$HOME/go
export PATH=$GOPATH/bin:/home/wyatt/scripts:$HOME/bin:$HOME/.gem/ruby/2.2.0/bin:$HOME/.rvm/bin:/opt/puppetlabs/bin:$PATH:/usr/local/go/bin

#export NVM_DIR="$HOME/opt/bin/nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

export PATH="$HOME/.yarn/bin:$PATH"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export PATH="$HOME/.cargo/bin:$PATH"
source ~/.bash_env
