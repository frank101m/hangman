#!/bin/bash

#--loadINit
#killall play
#cat ./res/logo.txt
   # DATA[0]=" #     #    #    #     #  #####  #     #    #    #     #"
    #DATA[1]=" #     #   # #   ##    # #     # ##   ##   # #   ##    #"
    #DATA[2]=" #     #  #   #  # #   # #       # # # #  #   #  # #   #"
    #DATA[3]=" ####### #     # #  #  # #  #### #  #  # #     # #  #  #"
    #DATA[4]=" #     # ####### #   # # #     # #     # ####### #   # #"
    #DATA[5]=" #     # #     # #    ## #     # #     # #     # #    ##"
    #DATA[6]=" #     # #     # #     #  #####  #     # #     # #     #"
    #printf '%s\n' "${DATA[@]}"
cat ./res/logo.txt
cat ./res/hangmanProp.txt
(play -q ./res/backMusic.mp3 -V0) &

#--FinInit

#--gameInit
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
echo "__________"   
