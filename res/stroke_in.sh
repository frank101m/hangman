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


export -f inputValidation
