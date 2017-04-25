# .bash_profile

# If not running interactively, don't do anything
[[ -z "$PS1" ]] && return

# Source local definitions (if any)
for script in ~/.profile.d/{function,function_*,path,color,env,alias,grep,prompt}.sh ; do
	source $script
done
unset -v script

# Set LSCOLORS
eval "$(dircolors ~/.dir_colors)"

# Get the aliases and functions
if [[ -f ~/.bashrc ]] ; then
	source ~/.bashrc
fi
