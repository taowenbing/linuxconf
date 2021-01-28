# Sample .bashrc for SuSE Linux
# Copyright (c) SuSE GmbH Nuernberg

# There are 3 different types of shells in bash: the login shell, normal shell
# and interactive shell. Login shells read ~/.profile and interactive shells
# read ~/.bashrc; in our setup, /etc/profile sources ~/.bashrc - thus all
# settings made here will also take effect in a login shell.
#
# NOTE: It is recommended to make language settings in ~/.profile rather than
# here, since multilingual X sessions would not work properly if LANG is over-
# ridden in every subshell.

# Some applications read the EDITOR variable to determine your favourite text
# editor. So uncomment the line below and enter the editor of your choice :-)
#export EDITOR=/usr/bin/vim
#export EDITOR=/usr/bin/mcedit

# For some news readers it makes sense to specify the NEWSSERVER variable here
#export NEWSSERVER=your.news.server

# If you want to use a Palm device with Linux, uncomment the two lines below.
# For some (older) Palm Pilots, you might need to set a lower baud rate
# e.g. 57600 or 38400; lowest is 9600 (very slow!)
#
#export PILOTPORT=/dev/pilot
#export PILOTRATE=115200

#test -s ~/.alias && . ~/.alias || true
alias lf='ls -AF'
alias j='jobs -l'
alias h='history 25'
alias startx='startx -- -dpi 96'
alias global='global --result=grep'
alias ip='ip -c=never'

#acme_font=/mnt/font/FixedsysExcelsiorIIIb/12/font
acme_font=/mnt/font/GoMono/11a/font
alias em="$PLAN9/bin/acme -a -f $acme_font"
alias acme='tabstop=8 em'

case "$TERM" in
"dumb")
    PS1="> "
    ;;
*)
    PS1='\[\e[1m\e[31m\][\w]\$ \[\e[0m\]'
    ;;
esac

stty -ixon -ixoff	# disable XON XOFF (software flow control)

export MAN_POSIXLY_CORRECT=1
export EDITOR=/usr/local/bin/me
