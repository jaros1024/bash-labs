#!/bin/bash

WYGRANA="0"
GRACZ="2"
WEJSCIE=""

PLANSZA=("0" "0" "0" "0" "0" "0" "0" "0" "0")

function wyswietl {
    # clear
    echo "Plansza"
    echo "${PLANSZA[0]} | ${PLANSZA[1]} | ${PLANSZA[2]}"
    echo "${PLANSZA[3]} | ${PLANSZA[4]} | ${PLANSZA[5]}"
    echo "${PLANSZA[6]} | ${PLANSZA[7]} | ${PLANSZA[8]}"
}

function potwierdzWygrana {
    wyswietl
    echo "Wygral gracz ${GRACZ}"
    WYGRANA="1"
}

function sprawdzWygrana {
    for POLE in {0..2}
    do
        ROW=POLE*3
        if [ ${PLANSZA[$ROW]} -eq $GRACZ ] && [ ${PLANSZA[$[$ROW+1]]} -eq $GRACZ ] && [ ${PLANSZA[$[$ROW+2]]} -eq $GRACZ ]
        then
            potwierdzWygrana
        fi
        
        if [ ${PLANSZA[$POLE]} -eq $GRACZ ] && [ ${PLANSZA[$[$POLE+3]]} -eq $GRACZ ] && [ ${PLANSZA[$[$POLE+6]]} -eq $GRACZ ]
        then
            potwierdzWygrana
        fi
    done
    
    if [ ${PLANSZA[0]} -eq $GRACZ ] && [ ${PLANSZA[4]} -eq $GRACZ ] && [ ${PLANSZA[8]} -eq $GRACZ ]
    then
        potwierdzWygrana
    fi
    
    if [ ${PLANSZA[2]} -eq $GRACZ ] && [ ${PLANSZA[4]} -eq $GRACZ ] && [ ${PLANSZA[6]} -eq $GRACZ ]
    then
        potwierdzWygrana
    fi
}

function zmianaGracza {
    if [ $GRACZ -eq 1 ]
    then
        GRACZ="2"
    else
        GRACZ="1"
    fi
    
    echo "Ruch gracza ${GRACZ}"
}

function pobierzPole {
    echo "Podaj pole"
    read WEJSCIE
    while [ $WEJSCIE -gt 8 ] || [ $WEJSCIE -lt 0 ] || [ ${PLANSZA[$WEJSCIE]} -ne 0 ]
    do
        echo "Nieprawidlowe pole!"
        echo "Podaj pole"
        read WEJSCIE
    done
    return $WEJSCIE
}
        
echo "Kolko i krzyzyk"
while [ $WYGRANA -eq "0" ]
do
    wyswietl
    zmianaGracza
    pobierzPole
    PLANSZA[$WEJSCIE]=$GRACZ
    sprawdzWygrana
done

