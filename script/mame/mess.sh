#!/bin/sh

PS="mamearcade64"
PSPATH="$HOME/.mame/git"
PSBIN="$PSPATH/$PS"

cd $PSPATH
exec ./$PS -inipath "$PSPATH;$PSPATH/ini" "$@"
