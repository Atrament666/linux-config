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
alias netbeans='netbeans -J-Dswing.aatext=true -J-Dawt.useSystemAAFontSettings=lcd'

# priradi do PATH adresare bin v domovskem adresari
export PATH="~/bin:$PATH"

if [ -f ~/.bash_powerline.sh  ]; then
    . ~/.bash_powerline.sh
fi

# nastavení historie
unset HISTFILESIZE
export PROMPT_COMMAND="history -a"
export HISTSIZE=5000
shopt -s histappend
shopt -s cdspell #corrects typos in names of directories
export HISTIGNORE="&"
complete -cf sudo

export LC_COLLATE=C
export ANDROID_HOME=/opt/android-sdk/

#barvy pro less
export LESS_TERMCAP_mb=$'\e[1;5;36m'  #blinking
export LESS_TERMCAP_md=$'\e[1;36m' #bold - 36 = cyan 
export LESS_TERMCAP_me=$'\e[0m' #normal (0 = reset)
export LESS_TERMCAP_se=$'\e[0m' #stop standout
export LESS_TERMCAP_so=$'\e[01;32m' #start standout - green (info line)
export LESS_TERMCAP_ue=$'\e[0m' #stop underline
export LESS_TERMCAP_us=$'\e[1;4;33m' #yellow underscored word
