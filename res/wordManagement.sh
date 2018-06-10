#!/bin/bash

wordOptionInput="" #Global variable to manage option selected in word management
currentWord=""

function wordManagement(){
    DATA[0]="==============================================="
    DATA[1]="          ADMINISTRAR PALABRAS"
    DATA[2]="               (1) Agregar palabra"
    DATA[3]="               (2) Eliminar palabra"
    DATA[4]="               (3) Regresar"
    
    printf '%s\n' "${DATA[@]}"
    unset DATA

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
        printf "\033[1;32mPalabra agregada correctamente\033[0m\n"
    else
        printf "\033[1;31mError al agregar la palabra. Contacte con soporte\033[0m\n"
    fi
    currentWord=""
}

function deleteWord(){
    printf "Tus palabras: \n"
    echo $(sudo -u postgres -H -- psql -d codigoabierto -c "SELECT * from palabra where usr='$username'" -t)
    echo $result
    printf "Ingrese el codigo de la palabra a borrar: \n"
}

function getWordOption(){
    #Validating input so that it works only with 1, 2 or 3 keypresses.
    while true; do
        read -rsn1 wordOptionInput
        if [ "$wordOptionInput" = "1" ] || 
            [ "$wordOptionInput" = "2" ] || 
            [ "$wordOptionInput" = "3" ]; then
            break;
        fi
    done
}


export -f wordManagement
