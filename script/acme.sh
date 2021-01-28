#!/opt/plan9port/bin/rc

NAMESPACE = `{mktemp -d}
plumber >/dev/null >[2=1]
#font = /home/taoweb/prog/src/acme-font/font.hack/R.14.font
vfont=/mnt/font/GoMono/11a/font
#vfont=/mnt/font/FixedsysExcelsiorIIIb/12/font
ffont=$PLAN9/font/lucsans/euro.8.font

#tabstop=8
$PLAN9/bin/acme -a -f $vfont -F $ffont $*
rm -rf $NAMESPACE
