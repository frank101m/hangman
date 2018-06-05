#!/bin/bash
. ./res/logo.txt
. ./res/hangmanProp.txt
#--loadINit
#killall play
logoHangMan
propHangMan
#cat ./res/hangmanProp.txt
(play -q ./res/backMusic.mp3 -V0 -R) &

#--FinInit

#--gameInit
echo "_ _ _ _ _ _ _ _ _ _"
echo  
echo "q para salir"
while true; do
	read -rsn1 input
	if [ "$input" = "q" ]; then
		killall play
    		echo "Fin Juego"
		break;
	fi
done
#--FinINit

#Word

