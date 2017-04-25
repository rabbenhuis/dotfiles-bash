function my_ps() {
	ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ;
}

function pp() {
	my_ps f | awk '!/awk/ && $0~var' var=${1:-".*"} ;
}

# kill by process name
function killps() {
	local pid pname sig="-TERM"   # default signal

	if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
		echo "Usage: killps [-SIGNAL] pattern"
		return;
	fi

	if [ $# = 2 ]; then sig=$1 ; fi
	for pid in $(my_ps| awk '!/awk/ && $0~pat { print $1 }' pat=${!#} ); do
		pname=$(my_ps | awk '$1~var { print $5 }' var=$pid )
		if ask "Kill process $pid <$pname> with signal $sig?"
		then kill $sig $pid
		fi
	done
}
