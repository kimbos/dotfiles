#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export EDITOR="/usr/bin/vim" # for sudoedit
eval `keychain --eval id_rsa 2>/dev/null` 

# enable bash completion in interactive shells
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Color scheme
alias ls='ls --color=auto'
START_COLOR="\[\e[0;90m\]"
END_COLOR="\[\e[0m\]"
PATH_COLOR="\[\e[0;96m\]"
RESET="\[\e[0m\]"

if [ "#TERM" ]; then
	case $TERM in
	xterm*)
		PS1="$PATH_COLOR[$START_COLOR\h$PATH_COLOR \W$PATH_COLOR] $END_COLOR"
		PS2="$START_COLOR>\[$START_COLOR] "
		;;
	linux*)
		PS1="$RESET[$START_COLOR\h\[$PATH_COLOR \w$RESET] $END_COLOR"
		PS2="$START_COLOR>\\$RESET[$END_COLOR] "
		;;
	vt100*)
		PS1="[$START_COLOR\h\[$END_COLOR \w] "
		PS2="$START_COLOR>\[$END_COLOR] "
		;;
	*)
		PS1="bash\\$ "
		;;
	esac
fi


