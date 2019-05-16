

VERCHK_VERSION="0.0.1.2"
MODULE="$1"
GNU_URL=http://gnu.mirror.iweb.com/

verchk() {
	wget -q $GNU_URL/$MODULE -O /tmp/verchk-$MODULE.html &&
	grep -o 'href="'$MODULE'-[0-9]*.*'$1'"' /tmp/verchk-$MODULE.html |
		sed '/latest/d;s/href=//g;s/"//g' |sort -V |tail -n1
	rm /tmp/verchk-$MODULE.html
}

case "$MODULE" in
autoconf) verchk xz;;
automake) verchk xz;;
bc) verchk gz;;
bison) verchk xz;;
coreutils) verchk xz;;
cpio) verchk bz2;;
ddrescue) verchk lz;;
diffutils) verchk xz;;
ed) verchk lz;;
fdisk) verchk bz2;;
findutils) verchk gz;;
fontutils) verchk gz;;
gawk) verchk xz;;
gdb) verchk xz;;
gdbm) verchk gz;;
gettext) verchk xz;;
gmp) verchk xz;;
grep) verchk xz;;
groff) verchk gz;;
-V|--version) echo "verchk.sh $VERCHK_VERSION" && exit 0;;
*) echo "Usage: verchk.sh MODULE" && exit 22;;
esac

