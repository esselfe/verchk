#!/bin/bash

VERCHK_VERSION="0.0.1.3"
MODULE="$1"
GNU_URL=http://gnu.mirror.iweb.com/

vc_gnu() {
	wget -q $GNU_URL/$MODULE -O /tmp/verchk-$MODULE.html &&
	grep -Eo 'href="'$MODULE'-[0-9]*.*(xz|bz2|gz|lz)"' /tmp/verchk-$MODULE.html |
		sed '/latest/d;s/href=//g;s/"//g' |sort -V |tail -n1
	rm /tmp/verchk-$MODULE.html
}

case "$MODULE" in
autoconf) vc_gnu;;
automake) vc_gnu;;
bc) vc_gnu;;
bison) vc_gnu;;
coreutils) vc_gnu;;
cpio) vc_gnu;;
ddrescue) vc_gnu;;
diffutils) vc_gnu;;
ed) vc_gnu;;
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
-V|--version) echo "verchk.sh $VERCHK_VERSION" && exit 0;;
*) echo "Usage: verchk.sh MODULE" && exit 22;;
esac

