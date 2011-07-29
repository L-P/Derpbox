#!/bin/bash

# <contact@leo-peltier.fr> wrote this file. As long as you retain this
# notice you can do whatever you want with this stuff. If we meet some day,
# and you think this stuff is worth it, you can buy me a beer in return.
#																Léo Peltier

# Outputs the help and quit if we have any parameter.
if [[ -n $@ ]]; then
	echo -e "Usage: ./install.sh\n"
	echo "This script will add a line to your crontab, update.sh will run every 5 minutes."
	exit 1
fi

# Include our libs.
cd $(dirname $0) # Be sure to be in the right directory to include the right files.
chmod +rx config.sh lib.sh update.sh remove.sh
. config.sh
. lib.sh


# Run some checks before running the update.
dbox::check_user		|| exit 2
dbox::check_software	|| exit 3
dbox::check_server		|| exit 4
dbox::check_path		|| exit 5

# Actually do something.
dbox::install_derpbox || exit 8

dbox::log "Succefully installed all the things."

