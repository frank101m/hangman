#! /bin/bash

function inputValidation(){
	read -n1 -s -r stroke
	valid="abcdefghijklmnopqrstuvwxyz1234567890_ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	res=""
	while [[ $stroke != "" ]]; do
	  if [[ ($valid = *${stroke,,}*) && ($stroke != "?") ]]; then
	  	res=$res${stroke,,}
	  	echo -en "\r$res"
	  fi
	  if [[ $stroke = $'\177' ]]; then
	    	res="${res%?}"
	   	echo -en "\r$res \b"
	  fi
	#  echo -en "\r$res"
	  read -n1 -s -r stroke
	done
	echo ""
	echo "palabra final: $res"
}


function selectWord(){
    random_word=`sudo -u postgres -H -- psql -d codigoabierto -qtAX -c "SELECT palabra from palabra where usr='$username' order by RANDOM() LIMIT 1"`
    echo $random_word
}

function saveScore(){
    DATE=$( date '+%Y-%m-%d %H:%M:%S' )
    sudo -u postgres -H -- psql -d codigoabierto -c "INSERT INTO puntaje(puntaje, usr, fecha) 
    VALUES($1, '$username', '$DATE')" -q
    echo 0
}


function beginGame(){
    clear
    word=$( selectWord )

    string=$( echo $word | sed -e 's/[a-zA-A0-9]/_ /g' )
    v_found=""
    wordlen=$(echo -n $word | wc -m)
    lives=$(($wordlen*20 + $1))
    
    while [ $lives -gt 0 ]; do
	printf "$string \t puntaje: $lives "
	read -p ">" guess

	guesslen=$(echo -n $guess | wc -m)
	
	if [ $guesslen -eq $wordlen ]; then
	    if [ "$guess" == "$word" ]; then
		printf "\n \t Exito, palabra descubierta! \n"
		break
	    else
		printf "\n \t Esta no es la palabra. \n"
		lives=$(($lives - (wordlen*10)))
	    fi
	fi
	
	if [ $guesslen -eq 1 ]; then
	    occurrence=$( echo $word | grep -o -n $guess | wc -l )
	    if [ $occurrence -eq 0 ]; then
		lives=$(($lives -10))
		printf "\n El caracter no se encuentra en la palabra \n"
	    else
		v_found=$v_found$guess
		printf "Correcto! El caracter se encontro en la palabra \n"
		string=$( echo $word | sed -e "s/[^$v_found]/_ /g" )
	    fi
	    if [ "$string" == "$word" ]; then
		printf "\n \t Exito, palabra descubierta! \n"
		break
	    fi
	else
	    printf "\n Intenta adivinar la palabra completa o letra por letra. Intentalo otra vez. \n"
	fi
    done
    printf "\n \t Fin de la partida. Puntaje: $lives \n"

    if [ $lives -gt 0 ]; then
	printf "¿Desea continuar jugando?(Y/n)>"
	while true; do
	    read -p ">" op
	    if [ "$op" == "y" ] || [ "$op" == "Y" ] || [ "$op" == "n" ] || [ "$op" == "N" ]; then break ; fi
	done
	if [ "$op" == "y" ] || [ "$op" == "Y" ] ; then beginGame $lives ; else saveScore $lives; fi
    else
	saveScore 0
    fi
}

export -f inputValidation
export -f beginGame
