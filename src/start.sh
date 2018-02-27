#!/bin/bash

GREEN='\033[0;32m'
BLUE='\033[1;34m'
RED='\033[0;31m'
NC='\033[0m'

function change_chall {
    clear
    echo "Que souhaitez-vous faire à présent ?"
    echo
    echo "1) Exploitation web de type injection SQL"
    echo "2) Exploitation système de type BufferOverflow"
    echo "3) Ingénierie sociale"
    echo "4) Quitter"
}

clear
#Création du dossier partagé entre l'hôte et le Docker
chmod -R 777 /home/user3/USB_KEY
echo -e "${BLUE}"
echo "+--------------------------------------------+"
echo "| Bienvenue dans ce tutoriel d'exploitation  |"
echo "+--------------------------------------------+"
echo -e "${NC}"
echo "Le but ici est d'obtenir les droits root sur cette image Docker basée sur Ubuntu"
echo "Pour parvenir à cette fin, plusieurs exploitations sont possibles"
echo
echo "Nous vous laissons alors le choix entre 3 des plus grandes catégories"
echo "d'exploitation connues sur les systèmes d'information :"
echo
echo

PS3="
Faîtes votre choix : "
options=("Exploitation web de type injection SQL" "Exploitation système de type BufferOverflow" "Ingénierie sociale" "Quitter")
select opt in "${options[@]}"
do
    case $opt in
        "Exploitation web de type injection SQL")
			clear
            echo "Vous allez être authentifié en tant que \"user1\""
            echo "Veuillez patienter durant le lancement du serveur..."
            apache2ctl start 2> /dev/null > /dev/null
            service mysql start 2> /dev/null > /dev/null
            echo
            echo "Depuis un navigateur sur votre système hôte accédez au site hébergé par ce "
            echo -e "Docker via l'url : \"${GREEN}localhost:4000${NC}\""
            echo
            echo "Ce site présente une vulnérabilité de type injection SQL, à vous de la trouver"
            echo "et de l'exploiter pour récupérer des informations sensibles"
            echo
            echo -e "NB : Vous pouvez toujours changer de challenge une fois celui-ci terminé (ou pas)"
            echo -e "avec le raccourci : ${GREEN}Ctrl+D${NC}"
            echo
            cd /home/user1 && su user1
            change_chall
            ;;
        "Exploitation système de type BufferOverflow")
            clear
            echo "Vous allez maintenant être authentifié en tant que \"user2\""
            echo
            echo "Essayez d'exploiter le binaire \"ageconvertor\" pour obtenir des accès qui"
            echo "vous sont à priori interdits sur le système"
            echo
            echo -e "NB : Vous pouvez toujours changer de challenge une fois celui-ci terminé (ou pas)"
            echo -e "avec le raccourci : ${GREEN}Ctrl+D${NC}"
            echo
            cd /home/user2 && su user2
            change_chall
            ;;
        "Ingénierie sociale")
            clear
            echo "Vous allez maintenant être authentifié en tant que \"user3\""
            echo
            echo -e "NB : Vous pouvez toujours changer de challenge une fois celui-ci terminé (ou pas)"
            echo -e "avec le raccourci : ${GREEN}Ctrl+D${NC}"
            echo
            cd /home/user3 && su user3
            change_chall
            ;;
        "Quitter")
            break
            ;;
        *) echo "Mauvaise saisie";;
    esac
done