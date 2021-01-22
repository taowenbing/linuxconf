# Sample .profile for SuSE Linux
# rewritten by Christian Steinruecken <cstein@suse.de>
#
# This file is read each time a login shell is started.
# All other interactive shells will only read .bashrc; this is particularly
# important for language settings, see below.

test -z "$PROFILEREAD" && . /etc/profile || true

# Most applications support several languages for their output.
# To make use of this feature, simply uncomment one of the lines below or
# add your own one (see /usr/share/locale/locale.alias for more codes)
# This overwrites the system default set in /etc/sysconfig/language
# in the variable RC_LANG.
#
#export LANG=de_DE.UTF-8	# uncomment this line for German output
#export LANG=fr_FR.UTF-8	# uncomment this line for French output
#export LANG=es_ES.UTF-8	# uncomment this line for Spanish output


# Some people don't like fortune. If you uncomment the following lines,
# you will have a fortune each time you log in ;-)

#if [ -x /usr/bin/fortune ] ; then
#    echo
#    /usr/bin/fortune
#    echo
#fi

TEXLIVE=/opt/texlive/stable
export PLAN9=/opt/plan9port
#export JAVA_HOME=/usr/java/latest
#export JRE_HOME=$JAVA_HOME/jre

PATH=$PATH:/usr/local/sbin:/usr/sbin:/sbin:\
$PLAN9/bin:\
$TEXLIVE/bin/x86_64-linux
#:$JAVA_HOME/bin

export MANPATH="$MANPATH:$TEXLIVE/texmf-dist/doc/man" #:$JAVA_HOME/man
export INFOPATH="/usr/local/share/info:/usr/share/info:$TEXLIVE/texmf-dist/doc/info"
#export MAKESYSPATH="$HOME/prog/mk"    # NetBSD bmake
#export GOPATH="$HOME/prog/go"
