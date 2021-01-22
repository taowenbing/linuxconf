#!/bin/sh

PS="mame"
PSPATH="$HOME/.mame"
PSBIN="$PSPATH/$PS"

exec $PSBIN -inipath "$PSPATH;.;$PSPATH/ini" "$@"

##########################################################################
##!/bin/sh
#
#PS="mame141"
#PSPATH="$HOME/.mame"
#PSBIN="$PSPATH/$PS"
#
#CURDIR=`pwd`
#ROMDIRS="$HOME/.mame/roms;$HOME/game/bios/mame;$HOME/game/jjroms;$HOME/game/jjroms/pgm;$HOME/game/jjroms/gedou;$HOME/game/jjroms/wof;$HOME/game/jjroms/stg;$HOME/game/jjroms/old;$CURDIR"
#INPUT_DIRECTORY="$HOME/.mame/inp;$CURDIR"
#
#cd $PSPATH
#exec $PSBIN -rp $ROMDIRS -input_directory $INPUT_DIRECTORY "$@"
