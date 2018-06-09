#!/bin/bash
. ./res/login.sh
. ./res/register.sh
. ./res/logo.txt
. ./res/hangmanProp.txt

optionInput=""


function initGame(){
	clear
	displayMenu
	getMenuOption
	
	#Input evaluation. 1- Play, 2 - Sign up, 3 - Exit .
	case $optionInput in
		"1")
			while true;do
				login
			done
			
			;;
		"2")
			register
			;;
		"3")
			printf "\n\n		Saliendo...\n\n"
			;;
	esac
	#--gameInit
	#propHangMan
	#cat ./res/hangmanProp.txt
	#(play -q ./res/backMusic.wav -V0 repeat 4294967294) &
	#echo "_ _ _ _ _ _ _ _ _ _"
	#echo  
	#printf "\n\t\tq para salir\n"
	#while true; do
	#	read -rsn1 input
	#	if [ "$input" = "q" ]; then
			#killall play
	#    		echo "Fin Juego"
	#		break;
	#	fi
	#done
	#--FinINit
}

function displayMenu(){
	#Menu display
	logoHangMan
}

function getMenuOption(){
	#Validating input so that it works only with 1,2, or 3 keypresses.
	while true; do
		read -rsn1 optionInput
		if [ "$optionInput" = "1" ] || [ "$optionInput" = "2" ] || [ "$optionInput" = "3" ]; then
			break;
		fi
	done
}

initGame




