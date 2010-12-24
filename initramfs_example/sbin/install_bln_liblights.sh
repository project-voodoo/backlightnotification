#!/sbin/busybox sh

# BacklightNotification
# Installs bln liblights
#
# Copyright Michael Richter (neldar)), Licence: GPLv3

# commands need:
#   test [-f, -gt]
#   strings
#   grep [-c] (no regex needed)
#   cp

# TODO: modify these paths to your needs
GREP='/sbin/busybox grep'
STRINGS='/sbin/busybox strings'
TEST='/sbin/busybox test'

## TODO: select the liblights name for your kernel/android version
# eclair:
#liblights_name=lights.default.so

# froyo:
liblights_name=lights.s5pc110.so
##

# TODO: change the sourcedir to your needs
liblights_sourcedir=/res/misc


# dont modifiy the destdir path
liblights_destdir=/system/lib/hw


# TODO: if you want, you can adjust the "log" lines
if $TEST $($STRINGS $liblights_destdir/$liblights_name | $GREP -c backlightnotification) -eq 0
    then
#	log "no bln liblights or liblights v0 found"
	if $TEST ! -f $liblights_destdir/${liblights_name}.backup
	    then
		cp $liblights_destdir/$liblights_name $liblights_destdir/${liblights_name}.backup
#		log "old liblights backed up"
#	    else
# only uncomment this else, if log below also is uncomment or script will fail
#		log "old liblights already backed up"
	fi
#	log "copying bln liblights"
	cp $liblights_sourcedir/$liblights_name $liblights_destdir/
	chmod 644 $liblights_destdir/$liblights_name
#    else
#	log "liblights version >= v1; nothing done"
fi

exit 0;