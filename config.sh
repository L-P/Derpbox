#!/bin/bash

# <contact@leo-peltier.fr> wrote this file. As long as you retain this
# notice you can do whatever you want with this stuff. If we meet some day,
# and you think this stuff is worth it, you can buy me a beer in return.
#																Léo Peltier

# You may happily edit the vars below.
export DBOX_HOST=localhost						# Remote server address.
export DBOX_USER=$USER							# Remote user name.
export DBOX_PORT=22								# Remote SSH port to use.
export DBOX_RPATH="/home/$USER/dbox_remote"		# Remote path where we will store our files.
export DBOX_LPATH="/home/$USER/dbox_local"		# Local path where our files are stored.
export DBOX_EXCLUDE="*.swp *.lock *~ *.od?#"

# Only change the vars below if you know what you are doing.
export DBOX_EXCLUDE_FILE='' # Don't change this, it will be overwritten by dbox::create_exclude_file
export DBOX_RSYNC_OPTS_DL='--update' # We don't want to overwrite changed files.
export DBOX_RSYNC_OPTS_UP=''
export DBOX_RSYNC_OPTS_BOTH="--verbose --recursive --checksum --one-file-system --compress
														--human-readable"
export DBOX_SSH_CMD="ssh -p $DBOX_PORT"

