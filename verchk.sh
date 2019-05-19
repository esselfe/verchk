#!/bin/bash

VERCHK_VERSION="0.0.1.7"
MODULE="$1"
GNU_URL="http://gnu.mirror.iweb.com/"
XORG_APP_URL="https://www.x.org/releases/individual/app/"
XORG_DATA_URL="https://www.x.org/releases/individual/data/"
XORG_DOC_URL="https://www.x.org/releases/individual/doc/"
XORG_FONT_URL="https://www.x.org/releases/individual/font/"
XORG_UTIL_URL="https://www.x.org/releases/individual/util/"

if [ "$1" = "-h" -o "$1" = "--help" -o "$1" = "help" ]; then
	echo "Usage: verchk { MODULENAME | clean | help }"
	exit 0
elif [ "$1" = "clean" ]; then
	rm -v /tmp/verchk-xorg-app.html
	rm -v /tmp/verchk-xorg-data.html
	rm -v /tmp/verchk-xorg-doc.html
	rm -v /tmp/verchk-xorg-font.html
	rm -v /tmp/verchk-xorg-util.html
fi

vc_gnu() {
	wget -q $GNU_URL/$MODULE -O /tmp/verchk-gnu-$MODULE.html &&
	grep -Eo 'href="'$MODULE'-[0-9]*.*(xz|bz2|gz|lz)"' /tmp/verchk-gnu-$MODULE.html |
		sed '/latest/d;s/href=//g;s/"//g' |sort -V |tail -n1
	rm /tmp/verchk-gnu-$MODULE.html
}
vc_xorg_app() {
	[ -f /tmp/verchk-xorg-app.html ] || wget -q $XORG_APP_URL -O /tmp/verchk-xorg-app.html &&
	grep -Eo 'href="'$MODULE'-[0-9]*.*(xz|bz2|gz|lz)"' /tmp/verchk-xorg-app.html |
		sed '/latest/d;s/href=//g;s/"//g' |sort -V |tail -n1
}
vc_xorg_data() {
	[ -f /tmp/verchk-xorg-data.html ] || wget -q $XORG_DATA_URL -O /tmp/verchk-xorg-data.html &&
	grep -Eo 'href="'$MODULE'-[0-9]*.*(xz|bz2|gz|lz)"' /tmp/verchk-xorg-data.html |
		sed '/latest/d;s/href=//g;s/"//g' |sort -V |tail -n1
}
vc_xorg_doc() {
	[ -f /tmp/verchk-xorg-doc.html ] || wget -q $XORG_DOC_URL -O /tmp/verchk-xorg-doc.html &&
	grep -Eo 'href="'$MODULE'-[0-9]*.*(xz|bz2|gz|lz)"' /tmp/verchk-xorg-doc.html |
		sed '/latest/d;s/href=//g;s/"//g' |sort -V |tail -n1
}
vc_xorg_font() {
	[ -f /tmp/verchk-xorg-font.html ] || wget -q $XORG_FONT_URL -O /tmp/verchk-xorg-font.html &&
	grep -Eo 'href="'$MODULE'-[0-9]*.*(xz|bz2|gz|lz)"' /tmp/verchk-xorg-font.html |
		sed '/latest/d;s/href=//g;s/"//g' |sort -V |tail -n1
}
vc_xorg_util() {
	[ -f /tmp/verchk-xorg-util.html ] || wget -q $XORG_UTIL_URL -O /tmp/verchk-xorg-util.html &&
	grep -Eo 'href="'$MODULE'-[0-9]*.*(xz|bz2|gz|lz)"' /tmp/verchk-xorg-util.html |
		sed '/latest/d;s/href=//g;s/"//g' |sort -V |tail -n1
}


case "$MODULE" in
appres) vc_xorg_app;;
autoconf) vc_gnu;;
automake) vc_gnu;;
bc) vc_gnu;;
bdftopcf) vc_xorg_app;;
bison) vc_gnu;;
bitmap) vc_xorg_app;;
coreutils) vc_gnu;;
cpio) vc_gnu;;
ddrescue) vc_gnu;;
diffutils) vc_gnu;;
ed) vc_gnu;;
editres) vc_xorg_app;;
encodings) vc_xorg_font;;
fdisk) vc_gnu;;
findutils) vc_gnu;;
font-adobe-dpi) vc_xorg_font;;
font-adobe-utopia-dpi) vc_xorg_font;;
font-adobe-utopia-type) vc_xorg_font;;
font-alias) vc_xorg_font;;
font-arabic-misc) vc_xorg_font;;
font-bh-dpi) vc_xorg_font;;
font-bh-lucidatypewriter-dpi) vc_xorg_font;;
font-bh-ttf) vc_xorg_font;;
font-bh-type) vc_xorg_font;;
font-bitstream-dpi) vc_xorg_font;;
font-bitstream-speedo) vc_xorg_font;;
font-bitstream-type) vc_xorg_font;;
font-cronyx-cyrillic) vc_xorg_font;;
font-cursor-misc) vc_xorg_font;;
font-daewoo-misc) vc_xorg_font;;
font-dec-misc) vc_xorg_font;;
font-ibm-type) vc_xorg_font;;
font-isas-misc) vc_xorg_font;;
font-jis-misc) vc_xorg_font;;
font-micro-misc) vc_xorg_font;;
font-misc-cyrillic) vc_xorg_font;;
font-misc-ethiopic) vc_xorg_font;;
font-misc-meltho) vc_xorg_font;;
font-misc-misc) vc_xorg_font;;
font-mutt-misc) vc_xorg_font;;
font-schumacher-misc) vc_xorg_font;;
font-screen-cyrillic) vc_xorg_font;;
font-sony-misc) vc_xorg_font;;
font-sun-misc) vc_xorg_font;;
font-util) vc_xorg_font;;
font-winitzki-cyrillic) vc_xorg_font;;
font-xfree-type) vc_xorg_font;;
fontutils) vc_gnu;;
gawk) vc_gnu;;
gccmakedep) vc_xorg_util;;
gdb) vc_gnu;;
gdbm) vc_gnu;;
gettext) vc_gnu;;
gmp) vc_gnu;;
grep) vc_gnu;;
groff) vc_gnu;;
iceauth) vc_xorg_app;;
ico) vc_xorg_app;;
imake) vc_xorg_util;;
makedepend) vc_xorg_util;;
mkfontdir) vc_xorg_app;;
mkfontscale) vc_xorg_app;;
rgb) vc_xorg_app;;
setxkbmap) vc_xorg_app;;
showfont) vc_xorg_app;;
twm) vc_xorg_app;;
util-macros) vc_xorg_util;;
viewres) vc_xorg_app;;
xauth) vc_xorg_app;;
xbitmaps) vc_xorg_data;;
xcursor-themes) vc_xorg_data;;
xev) vc_xorg_app;;
xinit) vc_xorg_app;;
xinput) vc_xorg_app;;
xkbcomp) vc_xorg_app;;
xkbdata) vc_xorg_data;;
xkill) vc_xorg_app;;
xkeyboard-config)
	wget -q https://www.x.org/releases/individual/data/xkeyboard-config/ \
			-O /tmp/verchk-xorg-xkeyboard-config.html &&
	grep -Eo 'href="'$MODULE'-[0-9]*.*(xz|bz2|gz|lz)"' /tmp/verchk-xorg-xkeyboard-config.html |
		sed '/latest/d;s/href=//g;s/"//g' |sort -V |tail -n1
	rm /tmp/verchk-xorg-xkeyboard-config.html
	;;
xmessage) vc_xorg_app;;
xmodmap) vc_xorg_app;;
xorg-cf-files) vc_xorg_util;;
xorg-docs) vc_xorg_doc;;
xorg-sgml-doctools) vc_xorg_doc;;
xrandr) vc_xorg_app;;
xrdb) vc_xorg_app;;
xset) vc_xorg_app;;
xsetroot) vc_xorg_app;;
esac
