#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Use bash-completion, if available, and avoid double-sourcing
[[ $PS1 &&
  ! ${BASH_COMPLETION_VERSINFO:-} &&
  -f /usr/share/bash-completion/bash_completion ]] &&
    . /usr/share/bash-completion/bash_completion

export XDG_CURRENT_DESKTOP=river
export TERM=screen-256color
export EDITOR=nvim
export PATH="$HOME/.local/bin:$PATH"

alias ls='eza -l'
alias grep='grep --color=auto'
alias v='nvim'
alias wifi='impala'
alias audio='wiremix'
alias vclean='nvim_and_clean() { nvim "$1"; rm -f "$1"; }; nvim_and_clean'

eval "$(mise activate bash)"
eval "$(starship init bash)"
eval "$(zoxide init bash --cmd cd)"
eval "$(fzf --bash)"

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

