#!/bin/bash

score_option=""

function show_scores_menu()
{
   DATA[0]="==============================================="
   DATA[1]="      Puntuacion:"
   DATA[2]="        (1) Ver mis puntajes en orden"
   DATA[3]="        (2) Ver mis puntajes por fecha"
   DATA[4]="        (3) Ver puntaje global"
   DATA[5]="        (4) Regresar"

   printf '%s\n' "${DATA[@]}"
   unset DATA

   get_scores_option
   
   case $score_option in
     "1")display_scores_desc
       ;;
     "2")display_scores_time
       ;;
     "3")display_scores_global
       ;;
     "4")return_menu
       ;;
   esac
}
function return_menu()
{
  break
}
function get_scores_option()
{
  while true; do
    read -rsn1 score_option
    if [ "$score_option" = "1" ] ||
       [ "$score_option" = "2" ] ||
       [ "$score_option" = "3" ] ||
       [ "$score_option" = "4" ]; then
    break;
    fi
  done
}

function display_scores_desc()
{
  sudo -u postgres -H -- psql -d codigoabierto -c "SELECT * FROM puntaje WHERE usr = 'frank' ORDER BY puntaje DESC;"
#SELECT * FROM puntaje WHERE usr = '$usr' ORDER BY puntaje DESC;
  echo  "Presione una tecla para continuar"
  read -n1  
  clear
  show_scores_menu
} 

function display_scores_time()
{
  sudo -u postgres -H -- psql -d codigoabierto -c "SELECT * FROM puntaje WHERE usr = 'frank' ORDER BY fecha DESC;"
#SELECT * FROM puntaje WHERE usr = '$usr' ORDER BY puntaje DESC;
  echo  "Presione una tecla para continuar"
  read -n1  
  clear
  show_scores_menu

#SELECT * FROM puntaje WHERE usr = '$usr' ORDER BY fecha DESC;
}

function display_scores_global()
{
  sudo -u postgres -H -- psql -d codigoabierto -c "SELECT * FROM puntaje ORDER BY fecha DESC;"
#SELECT * FROM puntaje WHERE usr = '$usr' ORDER BY puntaje DESC;
  echo  "Presione una tecla para continuar"
  read -n1  
  clear
  show_scores_menu


#SELECT * FROM puntaje ORDER BY puntaje DESC;
}
export -f show_scores_menu

show_scores_menu
