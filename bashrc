# .bashrc

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# source global definitions (if any)
if [[ -f /etc/bashrc ]] ; then
	source /etc/bashrc
fi
