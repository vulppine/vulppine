echo "\nWelcome VULPPINE!\n"

if [ ! $(pidof Xorg) ]; then
	echo "Start X? [y]"
	read opt
	if [ "$opt" = "y" ]; then 
		echo "Starting X..."
		startx	
	else
	       	echo "Dropping to shell..." 
	fi
fi

