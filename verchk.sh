#!/bin/bash

VERCHK_VERSION="0.0.1.1"
MODULE="$1"
GNU_URL=http://gnu.mirror.iweb.com/

case "$MODULE" in
autoconf)
	wget -q $GNU_URL/$MODULE -O /tmp/verchk-$MODULE.html &&
	grep -o 'href="'$MODULE'-[0-9]*.*xz"' /tmp/verchk-$MODULE.html |
		sed '/latest/d;s/href=//g;s/"//g' |sort -V |tail -n1
	rm /tmp/verchk-$MODULE.html
	;;
automake)
	wget -q $GNU_URL/$MODULE -O /tmp/verchk-$MODULE.html &&
	grep -o 'href="'$MODULE'-[0-9]*.*xz"' /tmp/verchk-$MODULE.html |
		sed 's/href=//g;s/"//g' |sort -V |tail -n1
	rm /tmp/verchk-$MODULE.html
	;;
bc)
	wget -q $GNU_URL/$MODULE -O /tmp/verchk-$MODULE.html &&
	grep -o 'href="'$MODULE'-[0-9]*.*gz"' /tmp/verchk-$MODULE.html |
		sed 's/href=//g;s/"//g' |sort -V |tail -n1
	rm /tmp/verchk-$MODULE.html
	;;
bison)
	wget -q $GNU_URL/$MODULE -O /tmp/verchk-$MODULE.html &&
	grep -o 'href="'$MODULE'-[0-9]*.*xz"' /tmp/verchk-$MODULE.html |
		sed 's/href=//g;s/"//g' |sort -V |tail -n1
	rm /tmp/verchk-$MODULE.html
	;;
coreutils)
	wget -q $GNU_URL/$MODULE -O /tmp/verchk-$MODULE.html &&
	grep -o 'href="'$MODULE'-[0-9]*.*xz"' /tmp/verchk-$MODULE.html |
		sed 's/href=//g;s/"//g' |sort -V |tail -n1
	rm /tmp/verchk-$MODULE.html
	;;
cpio)
	wget -q $GNU_URL/$MODULE -O /tmp/verchk-$MODULE.html &&
	grep -o 'href="'$MODULE'-[0-9]*.*bz2"' /tmp/verchk-$MODULE.html |
		sed '/latest/d;s/href=//g;s/"//g' |sort -V |tail -n1
	rm /tmp/verchk-$MODULE.html
	;;
ddrescue)
	wget -q $GNU_URL/$MODULE -O /tmp/verchk-$MODULE.html &&
	grep -o 'href="'$MODULE'-[0-9]*.*lz"' /tmp/verchk-$MODULE.html |
		sed 's/href=//g;s/"//g' |sort -V |tail -n1
	rm /tmp/verchk-$MODULE.html
	;;
diffutils)
	wget -q $GNU_URL/$MODULE -O /tmp/verchk-$MODULE.html &&
	grep -o 'href="'$MODULE'-[0-9]*.*xz"' /tmp/verchk-$MODULE.html |
		sed 's/href=//g;s/"//g' |sort -V |tail -n1
	rm /tmp/verchk-$MODULE.html
	;;
ed)
	wget -q $GNU_URL/$MODULE -O /tmp/verchk-$MODULE.html &&
	grep -o 'href="'$MODULE'-[0-9]*.*lz"' /tmp/verchk-$MODULE.html |
		sed 's/href=//g;s/"//g' |sort -V |tail -n1
	rm /tmp/verchk-$MODULE.html
	;;
fdisk)
	wget -q $GNU_URL/$MODULE -O /tmp/verchk-$MODULE.html &&
	grep -o 'href="'$MODULE'-[0-9]*.*bz2"' /tmp/verchk-$MODULE.html |
		sed 's/href=//g;s/"//g' |sort -V |tail -n1
	rm /tmp/verchk-$MODULE.html
	;;
findutils)
	wget -q $GNU_URL/$MODULE -O /tmp/verchk-$MODULE.html &&
	grep -o 'href="'$MODULE'-[0-9]*.*gz"' /tmp/verchk-$MODULE.html |
		sed 's/href=//g;s/"//g' |sort -V |tail -n1
	rm /tmp/verchk-$MODULE.html
	;;
fontutils)
	wget -q $GNU_URL/$MODULE -O /tmp/verchk-$MODULE.html &&
	grep -o 'href="'$MODULE'-[0-9]*.*gz"' /tmp/verchk-$MODULE.html |
		sed 's/href=//g;s/"//g' |sort -V |tail -n1
	rm /tmp/verchk-$MODULE.html
	;;
gawk)
	wget -q $GNU_URL/$MODULE -O /tmp/verchk-$MODULE.html &&
	grep -o 'href="'$MODULE'-[0-9]*.*xz"' /tmp/verchk-$MODULE.html |
		sed 's/href=//g;s/"//g' |sort -V |tail -n1
	rm /tmp/verchk-$MODULE.html
	;;
gdb)
	wget -q $GNU_URL/$MODULE -O /tmp/verchk-$MODULE.html &&
	grep -o 'href="'$MODULE'-[0-9]*.*xz"' /tmp/verchk-$MODULE.html |
		sed 's/href=//g;s/"//g' |sort -V |tail -n1
	rm /tmp/verchk-$MODULE.html
	;;
gdbm)
	wget -q $GNU_URL/$MODULE -O /tmp/verchk-$MODULE.html &&
	grep -o 'href="'$MODULE'-[0-9]*.*gz"' /tmp/verchk-$MODULE.html |
		sed '/latest/d;s/href=//g;s/"//g' |sort -V |tail -n1
	rm /tmp/verchk-$MODULE.html
	;;
gettext)
	wget -q $GNU_URL/$MODULE -O /tmp/verchk-$MODULE.html &&
	grep -o 'href="'$MODULE'-[0-9]*.*xz"' /tmp/verchk-$MODULE.html |
		sed 's/href=//g;s/"//g' |sort -V |tail -n1
	rm /tmp/verchk-$MODULE.html
	;;
gmp)
	wget -q $GNU_URL/$MODULE -O /tmp/verchk-$MODULE.html &&
	grep -o 'href="'$MODULE'-[0-9]*.*xz"' /tmp/verchk-$MODULE.html |
		sed 's/href=//g;s/"//g' |sort -V |tail -n1
	rm /tmp/verchk-$MODULE.html
	;;
grep)
	wget -q $GNU_URL/$MODULE -O /tmp/verchk-$MODULE.html &&
	grep -o 'href="'$MODULE'-[0-9]*.*xz"' /tmp/verchk-$MODULE.html |
		sed 's/href=//g;s/"//g' |sort -V |tail -n1
	rm /tmp/verchk-$MODULE.html
	;;
-V|--version)
	echo "verchk.sh $VERCHK_VERSION" && exit 0
	;;
*)
	echo "Usage: verchk.sh MODULE" && exit 22
	;;
esac

