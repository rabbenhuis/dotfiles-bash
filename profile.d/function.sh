# Executable
is-executable() {
	local BIN=$(command -v "$1" 2>/dev/null)

	if [[ ! $BIN == "" && -x $BIN ]] ; then
		true;
	else 
		false;
	fi
}

is-supported() {
	if [[ $# -eq 1 ]] ; then
		if eval "$1" > /dev/null 2>&1 ; then
			true;
		else
			false;
		fi
	else
		if eval "$1" > /dev/null 2>&1 ; then
			echo -n "$2"
		else
			echo -n "$3"
		fi
	fi
}

# Add to path
prepend-path() {
	[[ -d $1 ]] && PATH="$1:$PATH"
}

# Get x-server
function get_xserver() {
	case $TERM in
		xterm)
			XSERVER=$(who am i | awk '{ print $NF }' | tr -d ')''(' )
			XSERVER=${XSERVER%%:*}
			;;
	esac
}

# Get current host related info.
function ii() {
	echo -e "\nYou are logged on ${AF_COLOR_BOLD_RED}${HOSTNAME}${COLOR_RESET}"
	echo -e "\n${AF_COLOR_BOLD_RED}Additionnal information:${COLOR_RESET} " ; uname -a
	echo -e "\n${AF_COLOR_BOLD_RED}Users logged on:${COLOR_RESET} " ; w -hs | cut -d " " -f1 | sort | uniq
	echo -e "\n${AF_COLOR_BOLD_RED}Current date :${COLOR_RESET} " ; date
	echo -e "\n${AF_COLOR_BOLD_RED}Machine stats :${COLOR_RESET} " ; uptime
	echo -e "\n${AF_COLOR_BOLD_RED}Memory stats :${COLOR_RESET} " ; free
	echo -e "\n${AF_COLOR_BOLD_RED}Diskspace :${COLOR_RESET} " ; mydf / $HOME
	echo -e "\n${AF_COLOR_BOLD_RED}Local IP Address :${COLOR_RESET} " ; my_ip
	echo -e "\n${AF_COLOR_BOLD_RED}Open connections :${COLOR_RESET} "; netstat -pan --inet;
	echo
}
