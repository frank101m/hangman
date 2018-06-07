#!/bin/bash

username=" "
password=" "

function login(){
	#clear
	echo "==============================================="
	read -p "	Ingrese su usuario: " username
	read -s -p "	Ingrese password: " password
	echo "==============================================="
	isUserInDB
}

function isUserInDB(){
    read -ra results <<< $(sudo -u postgres -H -- psql -d codigoabierto -c "SELECT * from t_user where name='$username' and password='$password'" -t)
    user="" 
    for piece in "${results[@]}"
    do
	    user+=$piece
    done	
    if [ -z $user ]; then
        echo -e "	Usuario no encontrado\n"
	    #clear
    else
	    clear
	    printf "		Bienvenido \033[0;31m$username\033[0m\n"
        break;
    fi
}
#while true; do
#    login
#done

export -f login
