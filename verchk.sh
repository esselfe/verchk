#!/bin/bash

VERCHK_VERSION="0.0.1.13"
[ -z "$VC_DEBUG" ] && VC_DEBUG=0
MODULE="$1"
GNU_URL="http://ftpmirror.gnu.org/"
#GNU_URL="http://gnu.mirror.iweb.com/"
XORG_APP_URL="https://www.x.org/releases/individual/app/"
XORG_DATA_URL="https://www.x.org/releases/individual/data/"
XORG_DOC_URL="https://www.x.org/releases/individual/doc/"
XORG_DRIVER_URL="https://www.x.org/releases/individual/driver/"
XORG_FONT_URL="https://www.x.org/releases/individual/font/"
XORG_UTIL_URL="https://www.x.org/releases/individual/util/"

if [ -z "$VC_DEBUG" -o $VC_DEBUG -eq 0 ]; then
	WGET_CMD="wget -q -t 1 -T 24 --no-proxy --no-cache --no-cookies"
else
	WGET_CMD="wget -v -t 1 -T 24 --no-proxy --no-cache --no-cookies"
fi

if [ "$1" = "-h" -o "$1" = "--help" -o "$1" = "help" ]; then
	echo "Usage: verchk.sh { MODULENAME | all | clean | help }"
	exit 0
elif [ "$1" = "clean" ]; then
	rm -v /tmp/verchk-xorg-{app,data,doc,driver,font,util}.html
	rm -v /tmp/verchk-gnu-*.html
fi

if [ "$1" = "all" -o "$1" = "-a" ]; then
	for m in `grep -o '^[a-z]*.*) ' $0 |sed '/^#/d;s/)//g;/^vc_/d;/grep -o/d'`; do
		if [ -z "`which lvu`" ]; then
			echo "$m `$0 $m`"
		else
			echo "$m `lvu installed $m |sed 's/.* not installed/not-installed/g'` `lvu version $m` `$0 $m`"
		fi
	done
	[ "$VC_DEBUG" -eq "0" ]	&& $0 clean
	exit 0
fi

vc_gnu() {
	[ -f "/tmp/verchk-gnu-$MODULE.html" ] || 
		$WGET_CMD $GNU_URL/$MODULE -O /tmp/verchk-gnu-$MODULE.html &&
	grep -Eo 'href="'$MODULE'-[0-9]+.*(xz|bz2|gz|lz)"' /tmp/verchk-gnu-$MODULE.html |
		sed '/latest/d;s/href=//g;s/"//g' |sort -V |tail -n1
	[ "$VC_DEBUG" -eq "0" ] && rm /tmp/verchk-gnu-$MODULE.html
}
vc_xorg_app() {
	[ -f /tmp/verchk-xorg-app.html ] || $WGET_CMD $XORG_APP_URL -O /tmp/verchk-xorg-app.html &&
	grep -Eo 'href="'$MODULE'-[0-9]+.*(xz|bz2|gz|lz)"' /tmp/verchk-xorg-app.html |
		sed '/latest/d;s/href=//g;s/"//g' |sort -V |tail -n1
}
vc_xorg_data() {
	[ -f /tmp/verchk-xorg-data.html ] || $WGET_CMD $XORG_DATA_URL -O /tmp/verchk-xorg-data.html &&
	grep -Eo 'href="'$MODULE'-[0-9]+.*(xz|bz2|gz|lz)"' /tmp/verchk-xorg-data.html |
		sed '/latest/d;s/href=//g;s/"//g' |sort -V |tail -n1
}
vc_xorg_doc() {
	[ -f /tmp/verchk-xorg-doc.html ] || $WGET_CMD $XORG_DOC_URL -O /tmp/verchk-xorg-doc.html &&
	grep -Eo 'href="'$MODULE'-[0-9]+.*(xz|bz2|gz|lz)"' /tmp/verchk-xorg-doc.html |
		sed '/latest/d;s/href=//g;s/"//g' |sort -V |tail -n1
}
vc_xorg_driver() {
	[ -f /tmp/verchk-xorg-driver.html ] || $WGET_CMD $XORG_DRIVER_URL -O /tmp/verchk-xorg-driver.html &&
	grep -Eo 'href="'$MODULE'-[0-9]+.*(xz|bz2|gz|lz)"' /tmp/verchk-xorg-driver.html |
		sed '/latest/d;s/href=//g;s/"//g' |sort -V |tail -n1
}
vc_xorg_font() {
	[ -f /tmp/verchk-xorg-font.html ] || $WGET_CMD $XORG_FONT_URL -O /tmp/verchk-xorg-font.html &&
	grep -Eo 'href="'$MODULE'-[0-9]+.*(xz|bz2|gz|lz)"' /tmp/verchk-xorg-font.html |
		sed '/latest/d;s/href=//g;s/"//g' |sort -V |tail -n1
}
vc_xorg_util() {
	[ -f /tmp/verchk-xorg-util.html ] || $WGET_CMD $XORG_UTIL_URL -O /tmp/verchk-xorg-util.html &&
	grep -Eo 'href="'$MODULE'-[0-9]+.*(xz|bz2|gz|lz)"' /tmp/verchk-xorg-util.html |
		sed '/latest/d;s/href=//g;s/"//g' |sort -V |tail -n1
}

case "$MODULE" in
gcc)
	[ -f "/tmp/verchk-gnu-gcc.html" ] || $WGET_CMD $GNU_URL/$MODULE -O /tmp/verchk-gnu-gcc.html &&
	grep -Eo 'href="gcc-[0-9]+.*(xz|bz2|gz|lz)"' /tmp/verchk-gnu-gcc.html |
		sed '/latest/d;s/href=//g;s/"//g;/^gcc-vms/d' |sort -V |tail -n1
	[ "$VC_DEBUG" -eq "0" ] && rm /tmp/verchk-gnu-gcc.html
	;;
ghostscript) # vc_gnu;;
	[ -f "/tmp/verchk-gnu-ghostscript.html" ] || 
		$WGET_CMD $GNU_URL/ghostscript -O /tmp/verchk-gnu-ghostscript.html &&
	grep -Eo 'href="ghostscript-[0-9]+\..*(xz|bz2|gz|lz)"' /tmp/verchk-gnu-ghostscript.html |
		sed '/latest/d;s/href=//g;s/"//g' |sort -V |tail -n1
	[ "$VC_DEBUG" -eq "0" ] && rm /tmp/verchk-gnu-ghostscript.html
	;;
guile) # vc_gnu;;
	[ -f "/tmp/verchk-gnu-guile.html" ] || 
		$WGET_CMD $GNU_URL/guile -O /tmp/verchk-gnu-guile.html &&
	grep -Eo 'href="guile-[0-9]+\..*(xz|bz2|gz|lz)"' /tmp/verchk-gnu-guile.html |
		sed '/latest/d;s/href=//g;s/"//g' |sort -V |tail -n1
	[ "$VC_DEBUG" -eq "0" ] && rm /tmp/verchk-gnu-guile.html
	;;
xkeyboard-config) # vc_xorg_data;;
	$WGET_CMD https://www.x.org/releases/individual/data/xkeyboard-config/ \
			-O /tmp/verchk-xorg-xkeyboard-config.html &&
	grep -Eo 'href="xkeyboard-config-[0-9]*\..*(xz|bz2|gz|lz)"' /tmp/verchk-xorg-xkeyboard-config.html |
		sed '/latest/d;s/href=//g;s/"//g' |sort -V |tail -n1
	[ "$VC_DEBUG" -eq "0" ] && rm /tmp/verchk-xorg-xkeyboard-config.html
	;;
a2ps) vc_gnu;;
acct) vc_gnu;;
aspell) vc_gnu;;
autoconf) vc_gnu;;
autoconf-archive) vc_gnu;;
autogen) vc_gnu;;
automake) vc_gnu;;
bash) vc_gnu;;
bc) vc_gnu;;
binutils) vc_gnu;;
bison) vc_gnu;;
clisp) vc_gnu;;
coreutils) vc_gnu;;
cpio) vc_gnu;;
ddrescue) vc_gnu;;
ddd) vc_gnu;;
diffutils) vc_gnu;;
ed) vc_gnu;;
emacs) vc_gnu;;
enscript) vc_gnu;;
#fdisk) vc_gnu;;
findutils) vc_gnu;;
flex) vc_gnu;;
#fontutils) vc_gnu;;
gawk) vc_gnu;;
gcal) vc_gnu;;
gcl) vc_gnu;;
gdb) vc_gnu;;
gdbm) vc_gnu;;
gengetopt) vc_gnu;;
gettext) vc_gnu;;
gforth) vc_gnu;;
#git) vc_gnu;;
glibc) vc_gnu;;
gmp) vc_gnu;;
gnutls) vc_gnu;;
gperf) vc_gnu;;
grep) vc_gnu;;
groff) vc_gnu;;
grub) vc_gnu;;
gsl) vc_gnu;;
gzip) vc_gnu;;
idutils) vc_gnu;;
indent) vc_gnu;;
inetutils) vc_gnu;;
less) vc_gnu;;
libcdio) vc_gnu;;
libidn) vc_gnu;;
libmicrohttpd) vc_gnu;;
libsigsegv) vc_gnu;;
libtasn1) vc_gnu;;
libtool) vc_gnu;;
libunistring) vc_gnu;;
libxmi) vc_gnu;;
m4) vc_gnu;;
mailman) vc_gnu;;
mailutils) vc_gnu;;
make) vc_gnu;;
mc) vc_gnu;;
mpc) vc_gnu;;
mpfr) vc_gnu;;
mtools) vc_gnu;;
nano) vc_gnu;;
nettle) vc_gnu;;
parted) vc_gnu;;
patch) vc_gnu;;
plotutils) vc_gnu;;
pth) vc_gnu;;
readline) vc_gnu;;
screen) vc_gnu;;
sed) vc_gnu;;
tar) vc_gnu;;
texinfo) vc_gnu;;
time) vc_gnu;;
unifont) vc_gnu;;
units) vc_gnu;;
wget) vc_gnu;;
which) vc_gnu;;
xboard) vc_gnu;;
zile) vc_gnu;;
rgb) vc_xorg_app;;
twm) vc_xorg_app;;
#viewres) vc_xorg_app;;
appres) vc_xorg_app;;
bdftopcf) vc_xorg_app;;
bitmap) vc_xorg_app;;
editres) vc_xorg_app;;
iceauth) vc_xorg_app;;
ico) vc_xorg_app;;
mkfontdir) vc_xorg_app;;
mkfontscale) vc_xorg_app;;
setxkbmap) vc_xorg_app;;
showfont) vc_xorg_app;;
xauth) vc_xorg_app;;
xev) vc_xorg_app;;
xinit) vc_xorg_app;;
xinput) vc_xorg_app;;
xkbcomp) vc_xorg_app;;
xkill) vc_xorg_app;;
xmessage) vc_xorg_app;;
xmodmap) vc_xorg_app;;
xrandr) vc_xorg_app;;
xrdb) vc_xorg_app;;
xset) vc_xorg_app;;
xsetroot) vc_xorg_app;;
xcursor-themes) vc_xorg_data;;
xbitmaps) vc_xorg_data;;
#xkbdata) vc_xorg_data;;
xorg-docs) vc_xorg_doc;;
xorg-sgml-doctools) vc_xorg_doc;;
#glamor-egl) vc_xorg_driver;;
xf86-input-acecad) vc_xorg_driver;;
xf86-input-aiptek) vc_xorg_driver;;
xf86-input-calcomp) vc_xorg_driver;;
xf86-input-citron) vc_xorg_driver;;
xf86-input-digitaledge) vc_xorg_driver;;
xf86-input-dmc) vc_xorg_driver;;
xf86-input-dynapro) vc_xorg_driver;;
xf86-input-elo2300) vc_xorg_driver;;
xf86-input-elographics) vc_xorg_driver;;
xf86-input-evdev) vc_xorg_driver;;
xf86-input-fpit) vc_xorg_driver;;
xf86-input-hyperpen) vc_xorg_driver;;
xf86-input-jamstudio) vc_xorg_driver;;
xf86-input-joystick) vc_xorg_driver;;
xf86-input-keyboard) vc_xorg_driver;;
xf86-input-libinput) vc_xorg_driver;;
xf86-input-magellan) vc_xorg_driver;;
xf86-input-magictouch) vc_xorg_driver;;
xf86-input-microtouch) vc_xorg_driver;;
xf86-input-mouse) vc_xorg_driver;;
xf86-input-mutouch) vc_xorg_driver;;
xf86-input-palmax) vc_xorg_driver;;
xf86-input-penmount) vc_xorg_driver;;
xf86-input-spaceorb) vc_xorg_driver;;
xf86-input-summa) vc_xorg_driver;;
xf86-input-synaptics) vc_xorg_driver;;
xf86-input-tek4957) vc_xorg_driver;;
xf86-input-ur98) vc_xorg_driver;;
xf86-input-vmmouse) vc_xorg_driver;;
xf86-input-void) vc_xorg_driver;;
#xf86-video-amd) vc_xorg_driver;;
xf86-video-amdgpu) vc_xorg_driver;;
xf86-video-apm) vc_xorg_driver;;
xf86-video-ark) vc_xorg_driver;;
xf86-video-ast) vc_xorg_driver;;
xf86-video-ati) vc_xorg_driver;;
xf86-video-chips) vc_xorg_driver;;
xf86-video-cirrus) vc_xorg_driver;;
xf86-video-cyrix) vc_xorg_driver;;
xf86-video-dummy) vc_xorg_driver;;
xf86-video-fbdev) vc_xorg_driver;;
xf86-video-freedreno) vc_xorg_driver;;
#xf86-video-geode) vc_xorg_driver;;
#xf86-video-glide) vc_xorg_driver;;
xf86-video-glint) vc_xorg_driver;;
xf86-video-i128) vc_xorg_driver;;
xf86-video-i740) vc_xorg_driver;;
#xf86-video-i810) vc_xorg_driver;;
#xf86-video-impact) vc_xorg_driver;;
#xf86-video-imstt) vc_xorg_driver;;
xf86-video-intel) vc_xorg_driver;;
xf86-video-mach64) vc_xorg_driver;;
xf86-video-mga) vc_xorg_driver;;
xf86-video-modesetting) vc_xorg_driver;;
xf86-video-neomagic) vc_xorg_driver;;
xf86-video-newport) vc_xorg_driver;;
xf86-video-nouveau) vc_xorg_driver;;
xf86-video-nsc) vc_xorg_driver;;
xf86-video-nv) vc_xorg_driver;;
xf86-video-omap) vc_xorg_driver;;
xf86-video-openchrome) vc_xorg_driver;;
xf86-video-qxl) vc_xorg_driver;;
xf86-video-r128) vc_xorg_driver;;
xf86-video-radeonhd) vc_xorg_driver;;
xf86-video-rendition) vc_xorg_driver;;
xf86-video-s3) vc_xorg_driver;;
xf86-video-s3virge) vc_xorg_driver;;
xf86-video-savage) vc_xorg_driver;;
xf86-video-siliconmotion) vc_xorg_driver;;
xf86-video-sis) vc_xorg_driver;;
xf86-video-sisusb) vc_xorg_driver;;
#xf86-video-sunbw2) vc_xorg_driver;;
#xf86-video-suncg3) vc_xorg_driver;;
#xf86-video-suncg6) vc_xorg_driver;;
#xf86-video-suncg14) vc_xorg_driver;;
#xf86-video-sunffb) vc_xorg_driver;;
#xf86-video-sunleo) vc_xorg_driver;;
#xf86-video-suntcx) vc_xorg_driver;;
xf86-video-tdfx) vc_xorg_driver;;
#xf86-video-tga) vc_xorg_driver;;
xf86-video-trident) vc_xorg_driver;;
#xf86-video-tseng) vc_xorg_driver;;
xf86-video-v4l) vc_xorg_driver;;
xf86-video-vboxvideo) vc_xorg_driver;;
#xf86-video-vermilion) vc_xorg_driver;;
xf86-video-vesa) vc_xorg_driver;;
#xf86-video-vga) vc_xorg_driver;;
#xf86-video-via) vc_xorg_driver;;
xf86-video-vmware) vc_xorg_driver;;
xf86-video-voodoo) vc_xorg_driver;;
#xf86-video-wsfb) vc_xorg_driver;;
#xf86-video-xgi) vc_xorg_driver;;
#xf86-video-xgixp) vc_xorg_driver;;
encodings) vc_xorg_font;;
#font-adobe-dpi) vc_xorg_font;;
#font-adobe-utopia-dpi) vc_xorg_font;;
#font-adobe-utopia-type) vc_xorg_font;;
font-alias) vc_xorg_font;;
font-arabic-misc) vc_xorg_font;;
#font-bh-dpi) vc_xorg_font;;
#font-bh-lucidatypewriter-dpi) vc_xorg_font;;
font-bh-ttf) vc_xorg_font;;
#font-bh-type) vc_xorg_font;;
#font-bitstream-dpi) vc_xorg_font;;
font-bitstream-speedo) vc_xorg_font;;
#font-bitstream-type) vc_xorg_font;;
font-cronyx-cyrillic) vc_xorg_font;;
font-cursor-misc) vc_xorg_font;;
font-daewoo-misc) vc_xorg_font;;
font-dec-misc) vc_xorg_font;;
#font-ibm-type) vc_xorg_font;;
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
#font-xfree-type) vc_xorg_font;;
gccmakedep) vc_xorg_util;;
imake) vc_xorg_util;;
makedepend) vc_xorg_util;;
util-macros) vc_xorg_util;;
xorg-cf-files) vc_xorg_util;;
esac
