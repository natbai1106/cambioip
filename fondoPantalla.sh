#!/bin/bash

#---------------------------------#
# Examen Práctico 2do. Parcial    #
# Alumno: Alfredo Natarén Baires  #
# No. de Cuenta: 231051103        #
# Campus: San Pedro Sula          #
#---------------------------------#

OPTION=$(whiptail --title "Menú Cambio de Fondo de Pantalla" \
	--menu "Elige una opción" 11 70 3 \
	"1" "Fondo de Pantalla 1" \
	"2" "Fondo de Pantalla 2" \
	"3" "Regresar al menú principal" \
	3>&1 1<&2 2>&3)

case $OPTION in
	1) {
		for i in {0..100..25};do
		gsettings set org.gnome.desktop.background picture-uri "file:///home/natbai/ExamenIIP/img/img1.jpg"
		sleep 0.2
		echo $i
	done
		} | whiptail --gauge "Cambiando fondo de pantalla, por favor espere..." 6 50 0
	./fondoPantalla.sh
	;;

	2) {	
		for i in {0..100..25};do
		gsettings set org.gnome.desktop.background picture-uri "file:///home/natbai/ExamenIIP/img/img2.jpg"
		sleep 0.2
		echo $i
	done
		} | whiptail --gauge "Cambiando fondo de pantalla, por favor espere..." 6 50 0
	./fondoPantalla.sh
	;;

	3) ./ejercicioExamenII.sh
	;;

esac