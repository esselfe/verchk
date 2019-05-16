#!/bin/bash

VERCHK_VERSION="0.0.1.4"
MODULE="$1"
GNU_URL="http://gnu.mirror.iweb.com/"
XORG_APP_URL="https://www.x.org/releases/individual/app/"

vc_gnu() {
	wget -q $GNU_URL/$MODULE -O /tmp/verchk-$MODULE.html &&
	grep -Eo 'href="'$MODULE'-[0-9]*.*(xz|bz2|gz|lz)"' /tmp/verchk-$MODULE.html |
		sed '/latest/d;s/href=//g;s/"//g' |sort -V |tail -n1
	rm /tmp/verchk-$MODULE.html
}
vc_xorg() {
	# Only fetch the file once, all modules are on that page ...let a reboot clear the file
	[ -f /tmp/verchk-xorg-app.html ] || wget -q $XORG_APP_URL -O /tmp/verchk-xorg-app.html &&
	grep -Eo 'href="'$MODULE'-[0-9]*.*(xz|bz2|gz|lz)"' /tmp/verchk-xorg-app.html |
		sed '/latest/d;s/href=//g;s/"//g' |sort -V |tail -n1
#	rm /tmp/verchk-xorg-app.html
}

case "$MODULE" in
appres) vc_xorg;;
autoconf) vc_gnu;;
automake) vc_gnu;;
bc) vc_gnu;;
bdftopcf) vc_xorg;;
bison) vc_gnu;;
bitmap) vc_xorg;;
coreutils) vc_gnu;;
cpio) vc_gnu;;
ddrescue) vc_gnu;;
diffutils) vc_gnu;;
ed) vc_gnu;;
editres) vc_xorg;;
fdisk) vc_gnu;;
findutils) vc_gnu;;
fontutils) vc_gnu;;
gawk) vc_gnu;;
gdb) vc_gnu;;
gdbm) vc_gnu;;
gettext) vc_gnu;;
gmp) vc_gnu;;
grep) vc_gnu;;
groff) vc_gnu;;
iceauth) vc_xorg;;
ico) vc_xorg;;
mkfontdir) vc_xorg;;
mkfontscale) vc_xorg;;
rgb) vc_xorg;;
setxkbmap) vc_xorg;;
showfont) vc_xorg;;
twm) vc_xorg;;
viewres) vc_xorg;;
xauth) vc_xorg;;
xev) vc_xorg;;
xinit) vc_xorg;;
xinput) vc_xorg;;
xkbcomp) vc_xorg;;
xkill) vc_xorg;;
xmessage) vc_xorg;;
xmodmap) vc_xorg;;
xrandr) vc_xorg;;
xrdb) vc_xorg;;
xset) vc_xorg;;
xsetroot) vc_xorg;;
-V|--version) echo "verchk.sh $VERCHK_VERSION" && exit 0;;
*) echo "Usage: verchk.sh MODULE" && exit 22;;
esac

