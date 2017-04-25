# History settings
export HISTSIZE=32768
export HISTFILESIZE=131072
export SAVEHIST=4096
export HISTCONTROL=ignoredups:erasedups

# Enable colors
export CLICOLOR=1

# Prefer US English and use UTF-8
export LC_ALL="en_US.UTF-8"
export LANG="en_US"

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Recursive globbing with "**"
if [ ${BASH_VERSINFO[0]} -ge 4 ]; then
	shopt -s globstar
fi

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Do not autocomplete when accidentally pressing Tab on an empty line.
shopt -s no_empty_cmd_completion

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Automatic setting of $DISPLAY (if not set already)
if [[ -z ${DISPLAY:=""} ]]; then
	get_xserver

	if [[ -z ${XSERVER} || ${XSERVER} == $(hostname) || ${XSERVER} == "unix" ]]; then
		# Display on localhost
		DISPLAY=":0.0"
	else
		# Display on remote host
		DISPLAY=${XSERVER}:0.0
	fi
fi
export DISPLAY
