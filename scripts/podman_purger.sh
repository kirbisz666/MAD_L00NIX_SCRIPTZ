#!/bin/bash

###
### About: Script to automaticly purge unused podman leftovers.
###

### Warning

echo -e ""
echo -e "Warning! This script will purge all"
echo -e "stopped or unused podman components"
echo -e "and their leftovers."
echo -e "Make sure you know what you're doing!"
echo -e ""

### Eraser

PS3='Please enter your option: '
options=("Purge everything" "Exit")
select opt in "${options[@]}"
do
    case $opt in
        "Purge everything")
			podman container prune -f ; podman image prune -f ; podman network prune -f ; podman pod prune -f ; podman volume prune -f ; podman system prune -a -f
			break
            ;;
        "Exit")
        	exit
#			break
            ;;
    esac
done

echo -e ""
echo -e "Successfully purged everything"
echo -e ""

### Misc stuff
