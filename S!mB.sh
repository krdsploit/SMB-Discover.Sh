#!/usr/bin/bash

echo '''


	

──████─────────────────────────────████
───██████────────░█───█░────────██████
────██░▓████─────██───██─────████▓░██
─────██░░░▓███─────█─█─────███▓░░░██
─────██░░░░░▓███───█─█───███▓░░░░░██
──────██░░░░░░▓██──███──██▓░░░░░░██
──────██░░░░░░░▓███─█─██▓░░░░░░░░██
─────██░░░░░░░░░░▓█████▓░░░░░░░░░░██
─────██░░░░░░░░░░░▓███▓░░░░░░░░░░░██
─────█████████▒░░░░▓█▓░░░░▒█████████
───────█████████▒░░▒█▒░░▒█████████
────███░░░░░░░░██░░▓█▓░░██░░░░░░░░███
─────███░░░░░░░░░░░███░░░░░░░░░░░███
───────██░░░░░░░░░▓███▓░░░░░░░░░██
────────██░░░░░░░▓█████▓░░░░░░░██
────────██░░░░▓████─█─████▓░░░░██
─────────██░▓███────█────███▓░██
─────────██████───────────██████
──────────████─────────────████


" [!] Code Written By ==> ./Krdsploit.sh [!] "
" [!] SMB Scanner Provided By ./Shell    [!] "
" [!] Support : Linux - Mac - Windows    [!] "
" [!] GitHub : Krdsploit                 [!] "
" [!] Discord : KrdSploit#4087           [!] "

				


				'''

if [ 'id -u' -ne 0 ]; then
	echo " [*] Run As Root [*] "
	exit 1
fi

FILESYSTEM=cifs
SMBM=/usr/bin/smbmount
SMBC=/usr/bin/smbclient
NMBL=/usr/bin/nmblookup
NMAP=/usr/bin/nmap
GREP=/usr/bingrep
SED=/usr/bin/sed
DIALOG=/usr/bin/dialog
CHARSET="iso8859-1"
BUNT=1
TIMEOUT=5

test -x $DIALOG && DIALOG=$DIALOG
test -x $DIALOG && DIALOG=$DIALOG
test -x $SMBM || { echo -e 'smbmount not found !';exit 1; }
test -x $SMBC || { echo -e 'smbclient not found !';exit 1; }
test -x $NMBL || { echo -e 'nmblookup not found !';exit 1; }
test -x $NMAP || { echo -e 'nmap not found !';exit 1; }
test -x $GREP || { echo -e 'grep not found !';exit 1; }
test -x $SED || { echo -e 'sed not found !';exit 1; }

function script_kiddie() {
if [ $BUNT -eq 1 ]
then
    echo "ScR1p7k1dDi3 Pr0t3c7 Sy5t3m v 1.1"
	else
	    $DIALOG --title "v 1.1" --infobox " ScR1p7k1dDi3 Pr0t3c7 Sy5t3m" 6 20
fi
exit 1 
}
script_kiddie
 
if [ $# -eq 1 ]
then
    echo "$1" > ./out
        else
	    $DIALOG --title "SMBscan v.1.1" --inputbox "                Written by Krdsploit ;)
 
Please enter IP range
e.g 10.0.0.1-24 or 10.0.1-255.5-30
or type ./smbscan 10.0.0.1-254
 
http://code-reference.com <- get newest version" 13 50 2> ./out
fi
 
function check_it(){
SUM=0
X=`cat ./out | wc -c`
SUM=`expr $SUM + $X`
}
if [ $BUNT -eq 1 ]
    then
	    echo "Written by cd ;)"
	    echo "Scan started against to $1 on port 139"
	    echo "This can take a while"
fi
 
check_it
IP=`cat ./out`
rm -f ./out
$NMAP -p 139 -PN -T 5 -sT -v -v $IP  -oG ./$IP.out | $GREP Host
cat ./$IP.out | $GREP "139/open" | cut '-d ' -f 2 > ./out
rm -f ./$IP.out
check_it
if [ $SUM = 0 ]
    then 
	if [ $BUNT -eq 1 ]
	    then
echo "
    No SMB Server found.
 
      Thanks for use ..."
		rm -f ./out
		exit 1
		    else
			$DIALOG --title "Sorry" --infobox "
    No SMB Server found !
 
      Thanks for use ... " 7 30
			rm -f ./out
			exit 1
	fi
fi
 
if [ $BUNT -eq 1 ]
    then
	echo "Please wait...
      Searching 4 Shared Directories"
	else
	    $DIALOG --infobox "Please wait !
Searching 4 Shared Directories..." 5 40
fi
while read host ;
    do
	# Get Computer name
	echo "Try $host..."
        echo "Searching Name via nmblookup (B)"
	name=`$NMBL -A $host | $GREP "<00> -         B <ACTIVE>" | awk '{print $1}'`
 
	# Get Workgroup name
	workgroup=`$NMBL -A $host | $GREP "<00> - <GROUP>" | awk '{print $1}'`
 
	# if name not set so use this one
	workgroup=${workgroup:=WORKGROUP}
 
	name=${name:=IG_IT_IG_IT}
 
if [ $name = "IG_IT_IG_IT" ]
    then
	echo "Searching name via nmblookup (M)"
	name=`$NMBL -A $host | $GREP "<00> -         M <ACTIVE>" | awk '{print $1}'`
    fi 
    name=${name:=NONAME}
 
if [ $name = "NONAME" ]
    then
	echo "Searching Name via nmblookup (H)"
	name=`$NMBL -A $host | $GREP "<00> -         H <ACTIVE>" | awk '{print $1}'`
    fi
    name=${name:=NO_NAME}
 
if [ $name = "NO_NAME" ]
    then
	echo "Searching Name via Smbclient ... using Servername"
	name=`$SMBC -N -L $host -g | grep Server | awk {'print $1'} | cut -d '|' -f 2`
    fi
    name=${name:=NAME_NOT_FOUND}
 
 
	echo "looking for shared directorys on $host"
	kill -9 `pidof sleep` 2&>1
	$SMBC -W "$workgroup" -n "fuckup" -N  -L $host -g -p 139 | grep Disk | cut -f 2 -d '|'  > ./$host.shares 
	sleep $TIMEOUT || kill -9 `pidof $SMBC` 2&>1
 
	    exist=0
	    while read LIST ;
	    		do
		    exist=1
		    mkdir -p ./"$name-$host/$LIST"
		    $SMBM "//$host/$LIST" "./$name-$host/$LIST" -o defaults,guest,iocharset=utf8
 
			if [ $BUNT -eq 1 ]
			    then
				echo "trying to mount //$host/$LIST into ./$name-$host/$LIST"
			    else
				$DIALOG --infobox  "trying to mount //$host/$LIST into ./$name/$LIST" 10 60
			fi
		if [ $exist = 1 ]
		then
		    echo " 
		    $name - $host
		    Last found: `date`
		    Mapped    : `df -h | grep $host`" >> ./"$name-$host/ip-is-$host" 
		fi
	    done < ./$host.shares
 
rm -f ./$host.shares
done < ./out
 
mount | $GREP $FILESYSTEM > ./mounts
if [ $BUNT -eq 1 ]
    then
	echo "
SMBScan v 1.1 -> listing mounted smb file systems
 
`cat ./mounts | more`
"
    else
	$DIALOG --title "SMBScan v 1.1 -> listing mounted smb file systems" --textbox mounts 10 60
fi
rm -f ./mounts
rm -f ./out
clear