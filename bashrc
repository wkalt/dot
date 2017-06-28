set -o vi

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

# enable color support of ls and also add handy aliases
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
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'


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

if [ -n "$SSH_CONNECTION" ]; then
    PS1="\[\e[1;31m\][\u@\h \W]\`ruby -e \"print (%x{git branch 2> /dev/null}.match(/^\*.*/).to_s || '').gsub(/^\* (.+)$/, '(\1) ')\"\`$\[\e[0m\] "
fi

if [ "$(id -u)" == "0" ]; then
    PS1="\[\e[1;33m\][\u@\h \W]\`ruby -e \"print (%x{git branch 2> /dev/null}.match(/^\*.*/).to_s || '').gsub(/^\* (.+)$/, '(\1) ')\"\`$\[\e[0m\] "
fi

function proxy_on() {
    export no_proxy="localhost,127.0.0.1,localhost.localdomain,desktop"

    if (( $# > 0 )); then
        valid=$(echo $@ | sed -n 's/\([0-9]\{1,3\}.\)\{4\}:\([0-9]\+\)/&/p')
        if [[ $valid != $@ ]]; then
            >&2 echo "Invalid address"
            return 1
        fi

        export http_proxy="http://$1/"
        export https_proxy=$http_proxy
        export ftp_proxy=$http_proxy
        export rsync_proxy=$http_proxy
        echo "Proxy environment variable set."
        return 0
    fi

    echo -n "username: "; read username
    if [[ $username != "" ]]; then
        echo -n "password: "
        read -es password
        local pre="$username:$password@"
    fi

    echo -n "server: "; read server
    echo -n "port: "; read port
    export http_proxy="http://$pre$server:$port/"
    export https_proxy=$http_proxy
    export ftp_proxy=$http_proxy
    export rsync_proxy=$http_proxy
}

function proxy_off(){
    unset http_proxy
    unset https_proxy
    unset ftp_proxy
    unset rsync_proxy
    echo -e "Proxy environment variable removed."
}

export PATH=$PATH:/home/wyatt/.gem/ruby/2.2.0/bin
export PATH=$PATH:$HOME/.rvm/bin

source /home/wyatt/.rvm/scripts/rvm
export PATH=/home/wyatt/scripts:$PATH:/home/wyatt/bin

export PATH=/opt/puppetlabs/bin:$PATH

# OPAM configuration
. /home/wyatt/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
