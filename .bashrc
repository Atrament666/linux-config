#
# ~/.bashrc
#

# Atramentovo ultimatni .bashrc

[[ $- != *i* ]] && return

# barva promptu v zavislosti zda je spusteno jako root ci ne
if [[ $EUID -ne 0 ]]; then
  PS1=$'\[\033[32m\]\u250c[\u@\h][\w]\n\u2514\$\[\033[0m\] '
else
  PS1=$'\[\033[31m\]\u250c[\u@\h][\w]\n\u2514\$\[\033[0m\] '
fi

#nastavení kurzoru na blikající podtržítko
echo -e -n "\x1b[\x34 q"

# par sikovnych aliasu
alias ls='ls --color=auto --group-directories-first'
alias grep='grep --color=always'
alias less='less -R'
alias netbeans='netbeans -J-Dswing.aatext=true -J-Dawt.useSystemAAFontSettings=lcd'
alias mc='. /usr/lib/mc/mc-wrapper.sh'
alias vim='nvim'



# priradi do PATH adresare bin v domovskem adresari
export PATH="~/bin:$PATH"

if [ -f ~/.bash_powerline.sh  ]; then
    . ~/.bash_powerline.sh
fi

# nastavení historie
export PROMPT_COMMAND="history -a"
export HISTSIZE=-1
export HISTFILESIZE=-1
shopt -s histappend
shopt -s cdspell #corrects typos in names of directories
export HISTIGNORE="&:ps:htop:free:mc:history*"
complete -cf sudo

export LC_COLLATE=C
export ANDROID_HOME=/opt/android-sdk/
export EDITOR=vim
export MPD_HOST=localhost
export MPD_PORT=6600


export CXXFLAGS='-std=c++20 -Wall -Weffc++ -Wextra -Wsign-conversion'

#barvy pro less
export LESS_TERMCAP_mb=$'\e[1;5;36m'  #blinking
export LESS_TERMCAP_md=$'\e[1;36m' #bold - 36 = cyan 
export LESS_TERMCAP_me=$'\e[0m' #normal (0 = reset)
export LESS_TERMCAP_se=$'\e[0m' #stop standout
export LESS_TERMCAP_so=$'\e[01;32m' #start standout - green (info line)
export LESS_TERMCAP_ue=$'\e[0m' #stop underline
export LESS_TERMCAP_us=$'\e[1;4;33m' #yellow underscored word
export GROFF_NO_SGR=1

function mdcd {
    mkdir $1 && cd $1
}

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

