#!/bin/bash

. ./stroke_in.sh

username=" "
password=" "
valid="abcdefghijklmnopqrstuvwxyz1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ_."
$currentState="loginState"
# trap ctrl-c and call ctrl_c()
trap ctrl_c INT

function ctrl_c() {
    if [ "$currentState" = "loginState" ]
    then
        #initLogin
        #getPlayMenuOption
        break
        currentState="menuState"
        #exit
    fi
    exit
}

function initLogin(){
    printf "\n"
    DATA[0]="               (1) Login"
    DATA[1]="               (2) Registrarse"
    DATA[2]="               (3) Salir"
    DATA[3]=""
    printf '%s\n' "${DATA[@]}"
    unset DATA
}

function login(){
    #initLogin
    currentState="loginState"
	printf "*******************************************************\n"
    read -p "       Ingrese usuario: " username
	read -s -p "	Ingrese password: " password
	printf "\n"
	isUserInDB
}

function isUserInDB(){
    read -ra results <<< $(sudo -u postgres -H -- psql -d codigoabierto -c "SELECT * from login where usr='$username' and pwd='$password';" -t)
    user="" 
    for piece in "${results[@]}"
    do
	    user+=$piece
    done	
    if [ -z $user ]; then
        echo -e "	Usuario no encontrado\n"
    else
		clear
		#Showing connected user and changing to coloured username
        playerManagement #Contains player submenu, input options and play method. 
        break
    fi
}


export -f initLogin
export -f login
