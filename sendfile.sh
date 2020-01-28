#!/bin/sh

filename=$1
filetoSend=$2

echo "Sending Files or directory to list of servers using SCP protocol"
echo ""

send() {
	while read line

	do
	echo "Send File $filetoSend to Server $line"
	echo "----------------------------------------------"
	wait
	./sendfile.expect $filetoSend $line | egrep -v 'spawn'
	wait
	echo "----------------------------------------------"
	done < $filename
}


#main routine

if [ -z  $filename ] ; then
	echo ""
	echo "Usage : "
	echo "     ./sendfile.sh listfile filetoSend"
	echo ""
else

 send

fi
