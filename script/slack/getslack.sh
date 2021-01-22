#!/bin/bash

# Define a valid Slackware Linux Version.
# NOTE: If you want to use Slackware Linux Current,set VERSION to 'current' (VERSION=current).
VERSION=13.0

# Choose the faster one from the sites below and un-comment it.
#SOURCE="rsync://rsync.slackware.at/slackware/slackware-$VERSION"
#SOURCE="rsync://ftp.ntua.gr/pub/linux/slackware/slackware-$VERSION"
#SOURCE="rsync://ftp.slackware.com/slackware/slackware-$VERSION"
#SOURCE="rsync://alphageek.dyndns.org/slackware/slackware-$VERSION"
#SOURCE="rsync://rsync.vbfx.com/slackware/slackware-$VERSION"
#SOURCE="rsync://slackware.ipal.net/slackware-$VERSION"
#SOURCE="rsync://rsync.transamrit.net/slackware/slackware-$VERSION"
#SOURCE="rsync://closeedge.net/slackware/slackware-$VERSION"
#SOURCE="rsync://alphageek.dyndns.org/slackware/slackware-$VERSION"
#SOURCE="rsync://rsync.unspunproductions.com:8730/slackware/slackware-$VERSION"
#SOURCE="rsync://inferno.vbi.vt.edu/slackware/slackware-$VERSION"
#SOURCE="rsync://ftp.linuxslackers.org/slackware/slackware-$VERSION"
#SOURCE="rsync://rsync.unspunproductions.com:8730/slackware/slackware-$VERSION"
#SOURCE="rsync://drazi.geo.uib.no/slackware/slackware-$VERSION"
#SOURCE="rsync://carroll.cac.psu.edu/slackware/slackware-$VERSION"
#SOURCE="rsync://inferno.bioinformatics.vt.edu/slackware/slackware-$VERSION"
SOURCE="rsync://slackware.mirrors.tds.net/slackware/slackware-$VERSION"

# What do the OPTIONS & EXCLUDE parameters below mean? Please check the RSYNC manpages for details.And you can also make your own definitions.
OPTIONS="-avzH --delete --delete-before"

EXCLUDE="--exclude=slackware/kde --exclude=slackware/kdei --exclude=slackware/x --exclude=slackware/xap --exclude=slackware/y --exclude=slackware/e --exclude=slackware/f --exclude=slackware/t --exclude=slackware/tcl --exclude=extra --exclude=isolinux --exclude=kernels --exclude=pasture --exclude=source --exclude=testing --exclude=usb-and-pxe-installers"

EXCLUDE2="--exclude=slackware/a --exclude=slackware/ap --exclude=slackware/d --exclude=slackware/k --exclude=slackware/l --exclude=slackware/n"

EXCLUDE="$EXCLUDE $EXCLUDE2"

# Here define the destination path where the repository to be stored.
DEST=${DEST:-"/usr/distfiles/mirror/slackware"}

case "$1" in
	-c|--check)
	echo "Checking..."
	/usr/bin/rsync $OPTIONS $EXCLUDE --dry-run $SOURCE $DEST
	;;
	-d|--download)
	echo "Downloading..."
	/usr/bin/rsync $OPTIONS $EXCLUDE $SOURCE $DEST
	;;
	*)
	echo "Usage: `basename $0` {-c|-d}"
	echo -e "\t--check : To check for updates"
	echo -e "\t--download : To download updates"
	exit
	;;
esac
