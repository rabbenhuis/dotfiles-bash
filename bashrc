# .bashrc

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# source global definitions (if any)
if [[ -f /etc/bashrc ]] ; then
	source /etc/bashrc
fi

# Source local definitions (if any)
for script in ~/.profile.d/{function,function_*,path,color,env,alias,grep,prompt}.sh ; do
	source $script
done
unset -v script

# Set LSCOLORS
eval "$(dircolors ~/.dir_colors)"
