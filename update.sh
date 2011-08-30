#!/bin/bash

# <contact@leo-peltier.fr> wrote this file. As long as you retain this
# notice you can do whatever you want with this stuff. If we meet some day,
# and you think this stuff is worth it, you can buy me a beer in return.
#																Léo Peltier

# Outputs the help and quit if we have any parameter.
if [[ -n $@ ]]; then
	echo -e "Usage: ./update.sh\n"
	echo "Derpbox is a secure replacement for Dropbox, written in bash."
	echo "Released under the beer-ware license, a pint of cider is fine too."
	exit 1
fi

# Include our libs.
cd $(dirname $0) # Be sure to be in the right directory to include the right files.
. config.sh
. lib.sh


# Run some checks before running the update.
dbox::check_user		|| exit 2
dbox::check_server		|| exit 4
dbox::check_path		|| exit 5

# Actually do something.
dbox::create_exclude_file
dbox::update_local_from_remote	|| exit 6
dbox::update_remote_from_local	|| exit 7
rm $DBOX_EXCLUDE_FILE

dbox::log "Succefully updated all the things."

