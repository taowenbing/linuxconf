xset b 10 4000 200
xset s 1800
xset dpms 0 0 3600
xset +fp ~/.local/share/fonts/tamzen-font-master/bdf
#xset fp rehash
#xsetroot -mod 2 2 -fg rgb:55/40/55 -bg rgb:70/50/70

#xsetroot -solid rgb:50/50/78
#xsetroot -solid rgb:22/2e/45
#xv -quit -max -root 1.jpg
#display -window root 1.jpg

#export LC_CTYPE=zh_CN.utf8
#export DISPLAY=:0
#export FREETYPE_PROPERTIES="truetype:interpreter-version=35"

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
fcitx -d

#export XMODIFIERS=@im=IBUS
#ibus-daemon -r -x -d
#numlockx on

##exec ck-launch-session startxfce4
#exec fvwm
#exec startfluxbox
#exec dbus-launch --exit-with-session gnome-session
#exec dbus-launch --exit-with-session startkde
#exec i3
exec dbus-launch --exit-with-session openbox-session
