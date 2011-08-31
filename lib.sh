#!/bin/bash

# <contact@leo-peltier.fr> wrote this file. As long as you retain this
# notice you can do whatever you want with this stuff. If we meet some day,
# and you think this stuff is worth it, you can buy me a beer in return.
#																Léo Peltier

txtblu='\e[0;34m' # Blue
txtrst='\e[0m'    # Text Reset
txtred='\e[0;31m' # Red

## Checks if the server is online.
# Returns 0 if online, 1 otherwise.
function dbox::check_server() {
	ping -c 1 $DBOX_HOST > /dev/null || false
}


## Ouputs a log line to stdout.
function dbox::log() {
	echo -e "$txtblu[DBOX $(date +%s)]$txtrst $@"
}


## Outputs an error line to stderr.:w
function dbox::error() {
	echo -e "$txtred[DBOX $(date +%s)]$txtrst $@" 1>&2
}


## Checks if the required software are installed.
function dbox::check_software() {
	local bad_softs=''
	for soft in rsync cron crontab; do
		which $soft > /dev/null 2>&1 || bad_softs="$bad_softs $soft"
	done

	if [[ -n $bad_softs ]]; then
		dbox::error "The following program(s) need to be installed :$bad_softs."
		false
	fi
}


## Checks if we are root (failure) or not.
function dbox::check_user() {
	if [[ $UID -eq 0 ]]; then
		dbox::error "This script should not be run as root."
		false
	fi
}


## Checks if the local path exists.
function dbox::check_path() {
	if [[ -d $DBOX_LPATH ]]; then return 0; fi

	dbox::error "Local directory '$DBOX_LPATH' does not exist."
	mkdir $DBOX_LPATH
	
	if [[ -d $DBOX_LPATH ]]; then
		dbox::log "Succefully created directory '$DBOX_LPATH'"
		return 0
	fi

	dbox::error "Unable to create directory '$DBOX_LPATH'."
	false
}


## Updates our local directory with the files in the derpbox.
function dbox::update_local_from_remote() {
	dbox::log "Updating local path."
	rsync $DBOX_RSYNC_OPTS_BOTH $DBOX_RSYNC_OPTS_DL \
		--exclude-from="$DBOX_EXCLUDE_FILE" --rsh="$DBOX_SSH_CMD" \
		$DBOX_USER@$DBOX_HOST:"$DBOX_RPATH/" "$DBOX_LPATH/" > /dev/null
}


## Updates the derpbox with our local files.
function dbox::update_remote_from_local() {
	dbox::log "Updating the derpbox."
	rsync $DBOX_RSYNC_OPTS_BOTH $DBOX_RSYNC_OPTS_UP \
		--exclude-from="$DBOX_EXCLUDE_FILE" --rsh="$DBOX_SSH_CMD" \
		"$DBOX_LPATH/" $DBOX_USER@$DBOX_HOST:"$DBOX_RPATH/" > /dev/null
}


## Put a line in our crontab.
function dbox::install_derpbox() {
	curDir=$(pwd)
	local cronLine="*/5 * * * * $curDir/update.sh > /dev/null #derpbox_do_not_remove_comment"
	(crontab -l | grep -v "derpbox_do_not_remove_comment"; echo "$cronLine") | crontab - > /dev/null
}


## Removes the line from the crontab.
function dbox::remove_derpbox() {
	(crontab -l | grep -v "derpbox_do_not_remove_comment") | crontab - > /dev/null
}


## Creates the excludes file, fill it and put its path in DBOX_EXCLUDE_FILE
function dbox::create_exclude_file() {
	local path=$(mktemp --tmpdir='/tmp' 'dbox_excludes.XXXXXXXXXX')
	for ex in $DBOX_EXCLUDE; do
		echo $ex >> $path
	done

	DBOX_EXCLUDE_FILE=$path
}

