#!/bin/bash

GNU_URL=http://gnu.mirror.iweb.com/

case $1 in
autoconf)
	wget $GNU_URL/autoconf -O /tmp/verchk-autoconf.html
	grep -o 'href="autoconf-[0-9]*.*xz"' /tmp/verchk-autoconf.html |
		sed '/latest/d;s/href=//g;s/"//g' |sort -V |tail -n1
	rm /tmp/verchk-autoconf.html
	;;
*)
	echo "Usage: verchk.sh MODULE" && exit 22
	;;
esac

