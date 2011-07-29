#!/bin/bash

# <contact@leo-peltier.fr> wrote this file. As long as you retain this
# notice you can do whatever you want with this stuff. If we meet some day,
# and you think this stuff is worth it, you can buy me a beer in return.
#																Léo Peltier

# Outputs the help and quit if we have any parameter.
if [[ -n $@ ]]; then
	echo -e "Usage: ./remove.sh\n"
	echo "This script will remove derpbox from your crontab."
	exit 1
fi

# Include our libs.
cd $(dirname $0) # Be sure to be in the right directory to include the right files.
. lib.sh

dbox::remove_derpbox || exit 9

dbox::log "Succefully removed all the things."

