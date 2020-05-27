set -x PATH \
	/opt/firefox:$PATH \
	/home/adam/.local/bin \
	/home/linuxbrew/.linuxbrew/bin \
	$PATH

set -x EDITOR vim

set fish_greeting

alias v=vim
alias vi=vim

fish_vi_key_bindings

zoxide init fish | source
