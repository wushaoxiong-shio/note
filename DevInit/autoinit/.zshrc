export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

#http_proxy
#https_proxy
export PATH=/usr/lib/llvm-16/bin/:$PATH
export no_proxy=localhost,127.0.0.1

source $ZSH/oh-my-zsh.sh
