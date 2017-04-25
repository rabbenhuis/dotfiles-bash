# Aliases
alias df="df -kTh"

# Create a new directory and enter it
mk() {
	mkdir -p "$@" && cd "$@"
}

# Fuzzy find file/dir
ff() {  find . -type f -iname "$1";}
fff() { find . -type f -iname "*$1*";}
fd() {  find . -type d -iname "$1";}
fdf() { find . -type d -iname "*$1*";}

# Show disk usage of current folder, or list with depth
duf() {
	du --max-depth=${1:-0} -c | sort -r -n | awk '{split("K M G",v); s=1; while($1>1024){$1/=1024; s++} print int($1)v[s]"\t"$2}'
}

# Pretty-print of 'df' output
function mydf() {
	# Inspired by 'dfc' utility.
	for fs ; do
		if [[ ! -d $fs ]]; then
			echo -e $fs" :No such file or directory" ; continue
		fi

		local info=( $(command df -P $fs | awk 'END{ print $2,$3,$5 }') )
		local free=( $(command df -Pkh $fs | awk 'END{ print $4 }') )
		local nbstars=$(( 20 * ${info[1]} / ${info[0]} ))
		local out="["

		for ((j=0;j<20;j++)); do
			if [ ${j} -lt ${nbstars} ]; then
				out=$out"*"
			else
				out=$out"-"
			fi
		done

		out=${info[2]}" "$out"] ("$free" free on "$fs")"
		echo -e $out
	done
}

# Extract many types of compress files
# Source: http://nparikh.org/notes/zshrc.txt
extract() {
	if [ -f "$1" ]; then
		case "$1" in
			*.tar.bz2)  tar -jxvf "$1"            ;;
			*.tar.gz)   tar -zxvf "$1"            ;;
			*.bz2)    bunzip2 "$1"              ;;
			*.dmg)    hdiutil mount "$1"          ;;
			*.gz)     gunzip "$1"               ;;
			*.tar)    tar -xvf "$1"             ;;
			*.tbz2)   tar -jxvf "$1"            ;;
			*.tgz)    tar -zxvf "$1"            ;;
			*.zip)    unzip "$1"              ;;
			*.ZIP)    unzip "$1"              ;;
			*.pax)    cat "$1" | pax -r           ;;
			*.pax.Z)  uncompress "$1" --stdout | pax -r   ;;
			*.Z)    uncompress "$1"             ;;
			*)      echo "'$1' cannot be extracted/mounted via extract()" ;;
		esac
	else
		echo "'$1' is not a valid file to extract"
	fi
}

# Get gzipped file size
gz() {
	local ORIGSIZE=$(wc -c < "$1")
	local GZIPSIZE=$(gzip -c "$1" | wc -c)
	local RATIO=$(echo "$GZIPSIZE * 100/ $ORIGSIZE" | bc -l)
	local SAVED=$(echo "($ORIGSIZE - $GZIPSIZE) * 100/ $ORIGSIZE" | bc -l)

	printf "orig: %d bytes\ngzip: %d bytes\nsave: %2.0f%% (%2.0f%%)\n" "$ORIGSIZE" "$GZIPSIZE" "$SAVED" "$RATIO"
}

# Creates an archive (*.tar.gz) from given directory.
function maketar() {
	tar cvzf "${1%%/}.tar.gz"  "${1%%/}/";
}

# Create a ZIP archive of a file or folder.
function makezip() {
	zip -r "${1%%/}.zip" "$1" ;
}

# Make your directories and files access rights sane.
function sanitize() {
	chmod -R u=rwX,g=rX,o= "$@" ;
}
