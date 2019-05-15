#!/bin/bash

VERCHK_VERSION="0.0.1.0"
GNU_URL=http://gnu.mirror.iweb.com/

case $1 in
autoconf)
	wget -q $GNU_URL/autoconf -O /tmp/verchk-autoconf.html &&
	grep -o 'href="autoconf-[0-9]*.*xz"' /tmp/verchk-autoconf.html |
		sed '/latest/d;s/href=//g;s/"//g' |sort -V |tail -n1
	rm /tmp/verchk-autoconf.html
	;;
automake)
	wget -q $GNU_URL/automake -O /tmp/verchk-automake.html &&
	grep -o 'href="automake-[0-9]*.*xz"' /tmp/verchk-automake.html |
		sed 's/href=//g;s/"//g' |sort -V |tail -n1
	rm /tmp/verchk-automake.html
	;;
bc)
	wget -q $GNU_URL/bc -O /tmp/verchk-bc.html &&
	grep -o 'href="bc-[0-9]*.*gz"' /tmp/verchk-bc.html |
		sed 's/href=//g;s/"//g' |sort -V |tail -n1
	rm /tmp/verchk-bc.html
	;;
-V|--version)
	echo "verchk.sh $VERCHK_VERSION" && exit 0
	;;
*)
	echo "Usage: verchk.sh MODULE" && exit 22
	;;
esac

