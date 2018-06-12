#!/bin/bash

. ./stroke_in.sh

wordOptionInput="" #Global variable to manage option selected in word management
currentWord=""

function wordManagement(){
    while true; do
        clear
        printf "                ADMINISTRAR PALABRAS\n"
        printf "*******************************************************\n"
        printf "               (1) Agregar palabra  \n"
        printf "               (2) Eliminar palabra \n"
        printf "               (3) Regresar\n"
        getWordOption
        case $wordOptionInput in
            "1")addWord
                ;;
            "2")deleteWord
                ;;
            "3")break;
                ;;
        esac
    done
}

function addWord(){
    read -p "Ingrese la palabra: " currentWord
    sudo -u postgres -H -- psql -d codigoabierto -c "INSERT INTO palabra(palabra, puntos, usr) 
    VALUES('$currentWord', length('$currentWord')*20, '$username')" -q
    if [ $? -eq "0" ]; then
        printf "        \033[1;32mPalabra agregada correctamente\033[0m\n"
    else
        printf "        \033[1;31mError al agregar la palabra. Contacte con soporte\033[0m\n"
    fi
    currentWord=""
}

function deleteWord(){
    clear
    printf "        LISTADO DE PALABRAS DEL USUARIO $username \n"
    printf "*******************************************************\n"
    sudo -u postgres -H -- psql -d codigoabierto -c "SELECT id_palabra,palabra,puntos from palabra where usr='Luis'" -t 2> /dev/null | tr '|' ' '
    printf "Ingrese el codigo de la palabra a borrar: \n"
    read -p ">" idpalabra
	isWordInDB $idpalabra
}

function isWordInDB(){
    read -ra results <<< $(sudo -u postgres -H -- psql -d codigoabierto -c "SELECT * from palabra where id_palabra='$1';" -t 2> /dev/null)
    word="" 
    for piece in "${results[@]}"
    do
	    word+=$piece
    done	
    if [ -z $word ]; then
        echo -e "	Palabra no encontrada\n"
		sleep 1
    else
		#clear
		#Showing connected user and changing to coloured username
        #playerManagement #Contains player submenu, input options and play method. 
		echo -e "	Palabra encontrada\n"
		sudo -u postgres -H -- psql -d codigoabierto -c "DELETE from palabra where id_palabra='$1';" -t 2> /dev/null
		sleep 1
        #break
    fi
}


function getWordOption(){
    #Validating input so that it works only with 1, 2 or 3 keypresses.
    while true; do
        read -rsn1 -p "    Seleccione una opcion: " wordOptionInput
        printf "\n"
        if [ "$wordOptionInput" = "1" ] || 
            [ "$wordOptionInput" = "2" ] || 
            [ "$wordOptionInput" = "3" ]; then
            break;
        fi
    done
}


export -f wordManagement
