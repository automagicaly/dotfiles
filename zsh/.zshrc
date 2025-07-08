# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' matcher-list ''
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install

##################################
#             PROMPT             #
##################################
autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats '%b '

setopt PROMPT_SUBST
PROMPT='%F{green}%~%f %F{red}${vcs_info_msg_0_}%f$ '

##################################
#              XDG               #
##################################
export XDG_CONFIG_HOME="$HOME/.config"

##################################
#              ASDF              #
##################################
export ASDF_DATA_DIR="$HOME/.local/share/asdf"

##################################
#               GO               #
##################################
export GOPATH=$HOME/.local/share/go
export GOBIN=$GOPATH/bin

##################################
#              PATH              #
##################################
MY_PATH=""
MY_PATH=$MY_PATH:$HOME/.local/bin
MY_PATH=$MY_PATH:$ASDF_DATA_DIR/shims
MY_PATH=$MY_PATH:$GOBIN
MY_PATH=$MY_PATH:/opt/homebrew/bin/
export PATH=$MY_PATH:$PATH

#export PATH=$HOME/.local/bin:$ASDF_DATA_DIR/shims:$GOBIN:$HOME/.local/opt/go/bin:$HOME/.local/opt/zig:/opt/homebrew/bin/:$HOME/Library/Python/3.10:$PATH

##################################
#             DIRENV             #
##################################
eval "$(direnv hook zsh)"

##################################
#            ALIASES             #
##################################
alias ls="eza"

##################################
#          COMPLETIONS           #
##################################
eval "$(asdf completion zsh)"
