#!/bin/bash
. ./res/login.sh
. ./res/logo.txt
. ./res/hangmanProp.txt

#--loadINit
#killall play
while true;do
    login
done
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
(play -q ./res/backMusic.wav -V0 repeat 4294967294) &
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

