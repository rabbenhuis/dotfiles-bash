#!/bin/bash

# Copy the dotfiles
for dotfile in {bash_profile,bashrc,dir_colors} ; do
	if [[ -f ~/.$(basename $dotfile) ]] ; then
		rm -f ~/.$(basename $dotfile)
	fi

	cp $dotfile ~/.$(basename $dotfile)
done
unset -v dotfile

# Create required directories
for dir in {bin,.profile.d} ; do
	if [[ -d ~/${dir} ]] ; then
		rm -rf ~/${dir}
	fi

	mkdir -p ~/${dir}
	chmod 750 ~/${dir}
done

# Copy scripts to ~/.profile.d
for script in ./profile.d/*.sh ; do
	if [[ -r "$script" ]]; then
		cp $script ~/.profile.d/$(basename $script)
	fi
done
unset -v script
