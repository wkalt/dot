set -o vi
#
export HISTTIMEFORMAT="%m/%d/%y %T "
export TERM="screen-256color"
export EDITOR="vim"
export FACTERLIB=~/facter
export ANSIBLE_INVENTORY=~/ansible
export COLUMNS

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=200000

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

# assess the git branch in PS1
PS1="[\w] \`ruby -e \"print (%x{git branch 2> /dev/null}.match(/^\*.*/).to_s || '').gsub(/^\* (.+)$/, '(\1) ')\"\`$ "
#

# if logged in through an ssh connection, color the prompt red
if [ -n "$SSH_CONNECTION" ]; then
    PS1="\[\e[1;31m\][\u@\h \W]\`ruby -e \"print (%x{git branch 2> /dev/null}.match(/^\*.*/).to_s || '').gsub(/^\* (.+)$/, '(\1) ')\"\`$\[\e[0m\] "
fi

export PATH=/home/wyatt/scripts:$HOME/bin:$HOME/.gem/ruby/2.2.0/bin:$HOME/.rvm/bin:/opt/puppetlabs/bin:$PATH:/usr/local/go/bin:/home/wyatt/go/bin

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

source ~/.bash_env

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/wyatt/bin/google-cloud-sdk/path.bash.inc' ]; then . '/home/wyatt/bin/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/wyatt/bin/google-cloud-sdk/completion.bash.inc' ]; then . '/home/wyatt/bin/google-cloud-sdk/completion.bash.inc'; fi
export PATH="$HOME/.tgenv/bin:$PATH"
export PATH="$HOME/.tfenv/bin:$PATH"
export PATH="/home/wyatt/.local/bin:$PATH"

PATH="/home/wyatt/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/wyatt/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/wyatt/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/wyatt/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/wyatt/perl5"; export PERL_MM_OPT;
. "$HOME/.cargo/env"
