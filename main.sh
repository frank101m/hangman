#!/bin/bash
export currentState="menuState"
. ./res/login.sh
. ./res/register.sh
. ./res/wordManagement.sh
. ./res/scores_menu.sh
. ./res/logo.txt
. ./res/hangmanProp.txt

mainOptionInput=""
playOptionInput=""

function initGame(){
    while true; do
	    mainMenu
	    #Input evaluation. 1- Play, 2 - Sign up, 3 - Exit .
	    case $mainOptionInput in
		    "1")
			    while true;do
				    login
			    done
       			#playerManagement #Contains player submenu, input options and play method.                     

			    ;;
		    "2")
			    register #Available in res/register.sh
			    ;;
		    "3")
			    printf "\n\n		\033[1;31mSaliendo...\033[0m\n\n"
                exit
			    ;;
	    esac
    done
}

#Contains player submenu, input options and play method 
function playerManagement(){
	displayPlayerMenu
	getPlayMenuOption
	case $playOptionInput in
		"1")wordManagement #Go to wordManagement.sh
			;;
		"2") echo "PLAY METHODS SHOULD BE HERE"
			;;
		"3")show_scores_menu
      playerManagement
       ;;
		"4")clearSession
			clearGlobalVariables
			initGame
			;;
	esac
}

#Clear global variables related to user
function clearSession(){
	$username=" " #Global variable from res/login.sh
	$password=" " #Global variable from res/login.sh
}

#Clear global variables related to option inputs
function clearGlobalVariables(){
	mainOptionInput="" #Global variable 
	playOptionInput="" #Global variable
}

function mainMenu(){
	#Menu display
	clear
	logoHangMan
    initLogin
	getMainMenuOption
}

function getMainMenuOption(){
	#Validating input so that it works only with 1,2, or 3 keypresses.
	while true; do
		read -rn1 -p "	Seleccione una opcion: " mainOptionInput
		printf "\n"
		if [ "$mainOptionInput" = "1" ] || 
			[ "$mainOptionInput" = "2" ] || 
			[ "$mainOptionInput" = "3" ]; then
			break;
		fi
	done
}

function getPlayMenuOption(){
	#Validating input so that it works only with 1,2, 3 or 4 keypresses.
	while true; do
		read -rn1 -p "	Seleccione una opcion: " playOptionInput
		printf "\n"
		if [ "$playOptionInput" = "1" ] || 
			[ "$playOptionInput" = "2" ] || 
			[ "$playOptionInput" = "3" ] || 
			[ "$playOptionInput" = "4" ]; then
			break;
		fi
	done
}

function displayPlayerMenu(){
	clear
	printf "		BIENVENIDO \033[0;36m$username\033[0m\n"
	printf "*******************************************************\n"
    printf "               (1) Administrar palabras\n"
    printf "               (2) Jugar\n"
    printf "               (3) Ver mis puntajes\n"
    printf "               (4) Cerrar sesion\n"
}

initGame

export -f playerManagement
