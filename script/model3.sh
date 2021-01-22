#!/bin/sh

PS="Supermodel"
PSPATH="$HOME/game/supermodel/model3emu"
GMPATH="$HOME/game/roms/mame"

cd $PSPATH
if [ -n "$1" ]; then
    rom="$GMPATH/$1.zip"
    if [ -e $rom ]; then
        shift
# SDL1: SDL_DSP_NOSELECT=1 SDL_AUDIODRIVER=alsa
        ./$PS $rom "$@"
    else
        ./$PS "$@"
    fi
else
    ./$PS
fi
