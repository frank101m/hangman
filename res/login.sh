#!/bin/bash

. ./stroke_in.sh

username=" "
password=" "
valid="abcdefghijklmnopqrstuvwxyz1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ_."

function login(){
	echo "==============================================="
    read -p "       Ingrese usuario: " username
	read -s -p "	Ingrese password: " password
	printf "\n"
	isUserInDB
}

function isUserInDB(){
    read -ra results <<< $(sudo -u postgres -H -- psql -d codigoabierto -c "SELECT * from login where usr='$username' and pwd='$password'" -t)
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
		printf "		Bienvenido \033[0;36m$username\033[0m\n"
        break;
    fi
}

export -f login
