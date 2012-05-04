Derpbox
=======

THIS PROJECT IS DEPRECATED
--------------------------
Please use git instead.

What?
-----
Derpbox is a secure replacement for Dropbox, written in bash. Released
under the beer-ware license, a pint of cider is fine too. It runs fine
with GNU bash 4.2.8 and rsync 3.0.7.


Why?
----
I've been hearing from Dropbox for years now, it started with "hey, this
thing is awesome" and promptly went "how is that called 'security?'"
and now is "WTF, they are copyrighting our files". I still don't really
have the need for Dropbox but I sure could use something to sync my
.bashrc and .vimrc across all my work and home machines. So I wrote
something awesome, secure and open. Bash for the awesomeness, rsync for
the security and open because I like beer.
    

How?
---
Derpbox uses rsync to synchronize files and relies on cron to do it
automatically.  When two files are in conflict, the most recent one is
used. If the server was updated after you made modifications to your
local file, your changes will be lost.

Secure?
-------
As secure as SSH can be.


Installation?
-------------
### Three, easy steps to install derpbox :

1. Place all the .sh files in a directory, ~/.derp can do fine.
2. Edit `config.sh` and change what you need.
3. Run `install.sh`.

### Three, easy steps to setup a derpbox repository :

1. Install [rsync](http://rsync.samba.org/).
2. Create a dir you will use as `$DBOX_RPATH` in the client.
3. Get back to work.

### One, easy extra step for the clients and the server :

1. Don't forget to have a proper SSH configuration and working
   SSH keys, otherwise the derpbox won't work.

Removal?
-------
I don't know why you would do that, but just in case :

1. Run `remove.sh`
2. Remove manually all the files and scripts.


Who? When?
---------
    $ whoami
    leo
    $ date
    Thu Jul 28 22:29:55 CEST 2011


Bugs? Suggestions?
------------------
I'd be more that happy to receive an e-mail about it, you can find the
project and my address on Github : <https://github.com/L-P/Derpbox>

