#!/bin/bash

username=" "
password=" "

function register(){
	echo "============== REGISTRO ====================="
	read -p "	Ingrese su usuario: " username
	read -s -p "	Ingrese password: " password
	printf "\n"
	addUser
}

function addUser(){
    sudo -u postgres -H -- psql -d codigoabierto -c "INSERT INTO login VALUES('$username', '$password')" -q
    if [ $? -eq "0" ]; then
        printf "!BIENVENIDO!. Registro realizado correctamente\n"
    else
        printf "Error al registrar usuario. Contacte con soporte"
        sleep 2
        #break;
    fi
}

export -f register