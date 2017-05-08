if [[ $(command -v ssh-pageant) ]] ; then
        eval $(ssh-pageant -r -a "/tmp/.ssh-pageant-$USERNAME")
fi
