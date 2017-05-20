#
# ~/.bashrc
#

# Atramentovo ultimatni .bashrc

[[ $- != *i* ]] && return

# barva promptu v zavislosti zda je spusteno jako root ci ne
if [[ $EUID -ne 0 ]]; then
  PS1='\[\033[32m\][\u@\h][\w]\$\[\033[0m\] '
else
  PS1='\[\033[31m\][\u@\h][\w]\$\[\033[0m\] '
fi

# par sikovnych aliasu
alias ls='ls --color=auto --group-directories-first'
alias grep='grep --color=always'
alias less='less -R'

# priradi do PATH adresare bin v domovskem adresari
export PATH="$PATH:~/bin"

if [ -f ~/.bash_powerline.sh  ]; then
    . ~/.bash_powerline.sh
fi

# nastavení historie
unset HISTFILESIZE
export PROMPT_COMMAND="history -a"
shopt -s histappend
shopt -s cdspell #corrects typos in names of directories
export HISTIGNORE="&"
complete -cf sudo
