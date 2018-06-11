#!/bin/bash

. ./stroke_in.sh

wordOptionInput="" #Global variable to manage option selected in word management
currentWord=""

function wordManagement(){
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
        "3")playerManagement
            ;;
    esac
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
    playerManagement
}

function deleteWord(){
    clear
    printf "        LISTADO DE PALABRAS DEL USUARIO $username \n"
    printf "*******************************************************\n"
    result=$(sudo -u postgres -H -- psql -d codigoabierto -c "SELECT * from palabra where usr='$username'" -t)
    for line in $result; do
        echo $line
    done
    printf "Ingrese el codigo de la palabra a borrar: \n"
    read -p ">" word
    playerManagement
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
