#!/bin/bash

#---------------------------------#
# Examen Práctico 2do. Parcial    #
# Alumno: Alfredo Natarén Baires  #
# No. de Cuenta: 231051103        #
# Campus: San Pedro Sula          #
#---------------------------------#

function ChangeIp() {
    IPNOW=$(ip route get 1.2.3.4 | awk '{print $7}')
    USER=$(whoami)
    whiptail --yesno "Hola $USER, actualmente su IP es la $IPNOW, ¿Desea cambiarla?" 8 80 \
        --yes-button "Cambiar IP" \
        --no-button "Menú principal"
    ANSW=$?
    if [[ $ANSW -eq 0 ]]; then
        NEWIP=$(whiptail --inputbox "Ingrese la nueva dirección IP" 8 35 3>&1 1<&2 2>&3)
        status=$?
        if [ $status == 0 ]; then
            sudo echo -e "\nTYPE=Ethernet\nPROXY_METHOD=none\nBROWSER_ONLY=no\nBOOTPROTO=static\nDEFROUTE=yes\nIPV4_FAILURE_FATAL=no\nIPV6INIT=yes\nIPV6_AUTOCONF=yes\nIPV6_DEFROUTE=yes\nIPV6_FAILURE_FATAL=no\nIPV6_ADDR_GEN_MODE=stable-privacy\nNAME=ens33\nUUID=71f6661e-b994-46e5-ae69-09fdb1612faa\nDEVICE=ens33\nONBOOT=yes\nIPADDR=$NEWIP\nNETMASK=255.255.255.0\nGATEWAY=192.168.93.2\nDNS1=8.8.8.8" >/etc/sysconfig/network-scripts/ifcfg-ens33
            {
                for i in {0..100..25}; do
                    sudo service network restart
                    sudo systemctl restart network.service
                    sleep 0.01
                    echo $i
                done
            } | whiptail --gauge "Cambiando IP, por favor espere..." 6 50 0
            StartMenu
        else
            whiptail --msgbox "$USER, aún no cambió su IP, por favor cambiala" 8 50
            ChangeIp
        fi
    else
        StartMenu
    fi
}
#explicando git...................
function StartMenu() {
    op=$(whiptail --title "Programación para Sistemas Abiertos II - Ejercicio Examen II" \
        --menu "\n¿Que desea hacer?" 12 70 3 \
        "1" "Cambiar dirección IP" \
        "2" "Cambiar fondo de pantalla" \
        "3" "Salir" \
        3>&1 1<&2 2>&3)

    case $op in
    1)
        ChangeIp
        ;;

    2)
        ./fondoPantalla.sh
        ;;

    3)
        exit
        ;;

    esac
}

StartMenu
