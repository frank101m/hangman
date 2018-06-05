#!/bin/bash
. ./res/logo.txt
. ./res/hangmanProp.txt

#--loadINit
#killall play
logoHangMan
#--FinInit

#--PreGameInit
printf "\n\t\tPresiona 1 para empezar\n"
while true; do
	read -rsn1 input
	if [ "$input" = "1" ]; then
		break;
	fi
done
#--finInit

#--gameInit
propHangMan
#cat ./res/hangmanProp.txt
(play -q ./res/backMusic.mp3 -V0 -R) &
echo "_ _ _ _ _ _ _ _ _ _"
echo  
printf "\n\t\tq para salir\n"
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

