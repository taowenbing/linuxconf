#!/bin/sh

make SUBTARGET=arcade BUILDDIR=CNP SOURCES="src/mame/drivers/cps1.cpp,src/mame/drivers/cps2.cpp,src/mame/drivers/cps3.cpp,src/mame/drivers/neogeo.cpp,src/mame/drivers/pgm.cpp,src/mame/drivers/pgm2.cpp,src/mame/drivers/nes.cpp,src/mame/drivers/snes.cpp,src/mame/drivers/megadriv.cpp" -j5
