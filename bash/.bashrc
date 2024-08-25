#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# History
HISTCONTROL=ignoreboth # don't add duplicates or lines starting with spaces
shopt -s histappend    # append to history file, not overwrite
HISTSIZE=1000
HISTFILESIZE=10000

# Adjust windowsize variables after each command if needed
shopt -s checkwinsize

# Expand ** to match everything including subdirectories
shopt -s globstar

PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\]\$ '

case "$TERM" in
xterm* | rxvt*)
	PS1="\[\e]0;\u@\h:\w\a\]$PS1"
	;;
*) ;;
esac

# Set stuff to have colors
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ip='ip --color=auto'

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

if [ -e /usr/share/fzf/key-bindings.bash ]; then . /usr/share/fzf/key-bindings.bash; fi
if [ -e /usr/share/fzf/completion.bash ]; then . /usr/share/fzf/completion.bash; fi

export PATH=$PATH:~/.local/bin

eval "$(starship init bash)"
