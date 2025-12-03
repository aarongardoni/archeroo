#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export XDG_CURRENT_DESKTOP=river

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vim='nvim'
alias wifi='impala'
alias audio='wiremix'

eval "$(starship init bash)"
eval "$(mise activate bash)"
eval "$(zoxide init bash --cmd cd)"
eval "$(fzf --bash)"
