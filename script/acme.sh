#!/opt/plan9port/bin/rc

NAMESPACE = `{mktemp -d}
plumber >/dev/null >[2=1]
font=$HOME/.local/share/fonts/acme-font/font.hack/R.14.font
#font=$HOME/.local/share/fonts/acme-font/Go-Mono/Go-Mono.14.font
#font=/mnt/font/GoMono/11a/font
#font=/mnt/font/FixedsysExcelsiorIIIb/12/font
ffont=$PLAN9/font/lucsans/euro.8.font

#tabstop=8
$PLAN9/bin/acme -a -f $font -F $ffont $*
rm -rf $NAMESPACE
