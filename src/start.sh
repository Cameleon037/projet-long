#!/bin/bash

GREEN='\033[0;32m'
BLUE='\033[1;34m'
RED='\033[0;31m'
NC='\033[0m'

function echo_change_chall {
    clear
    echo
    echo -e "    ${BLUE}Que souhaitez-vous faire à présent ?${NC}"
    echo
    echo "          1) Exploitation web (injection SQL)"
    echo "          2) Exploitation système (Buffer overflow)"
    echo "          3) Ingénierie sociale et stéganographie"
    echo "          4) Quitter"
}

function echo_NB {
    echo -e "    NB : Vous pouvez changer de challenge à n'importe quel moment avec le raccourci : ${GREEN}Ctrl+D${NC}"
    echo
}

clear

#Création du dossier partagé entre l'hôte et le Docker
chmod -R 777 /home/olivier/USB_KEY

#Affichage du challenge
echo -e -n "${RED}"
cat /app/tuto-exploit.aa
echo -e -n "${NC}"
echo
echo -e "${BLUE}"
echo "                  +--------------------------------------------+"
echo "                  | Bienvenue dans ce tutoriel d'exploitation  |"
echo "                  +--------------------------------------------+"
echo -e "${NC}"
echo
echo "      Votre but est d'obtenir les droits root sur cette image Docker, basée sur Ubuntu."
echo "      Pour cela, nous vous proposons plusieurs tutoriels d'exploitation."
echo
echo "      À vous de choisir parmi ces tutoriels dont les exploitations font partie"
echo "      des plus connues sur les systèmes d'informations."
echo
echo
echo

options=("Exploitation web de type vulnérabilité SQL" "Exploitation système de type buffer overflow" \
    "Social engineering & stéganographie" "Quitter")
PS3="
      Faites votre choix : "
select option in "${options[@]}"
do
    case $option in
        "Exploitation web de type vulnérabilité SQL")
			clear
            echo
            echo -e "    Vous allez être authentifié en tant que ${BLUE}user1${NC}"
            echo "    Veuillez patienter durant le lancement du serveur..."
            apache2ctl start 2> /dev/null > /dev/null
            service mysql start 2> /dev/null > /dev/null
            echo
            echo -e "    Depuis un navigateur sur votre système hôte, accédez au site hébergé par ce Docker via l'URL : ${GREEN}localhost:4000${NC}"
            echo
            echo "    Avec vos talents de caméraman, vous avez décidé d'acheter une caméra compacte d'une marque"
            echo "    toute récente : MoGo. En vous rendant sur leur site Internet, vous commencez à douter de la"
            echo "    fiabilité de leur sécurité et voulez tester le site avant d'acheter en ligne votre caméra."
            echo "    Votre but : exploiter une vulnérabilité SQL pour récupérer des informations sensibles !"
            echo
            echo_NB
            echo
            cd /home/user1 && su user1
            echo_change_chall
            ;;
        "Exploitation système de type buffer overflow")
            clear
            echo
            echo -e "    Vous allez être authentifié en tant que ${BLUE}user2${NC}"
            echo
            echo "    Pour vous amuser, vous venez de télécharger un petit programme rédigé en C qui vous permet"
            echo "    de calculer votre âge en donnant votre date de naissance. Ce programme étant écrit par un"
            echo "    développeur anonyme, vous doutez de la sécurité associée."
            echo -e "    Votre but : exploiter une vulnérabilité de ${GREEN}ageconvertor${NC} pour obtenir un shell root !"
            echo
            echo -e "    Il est recommandé de lire le code source du binaire dans un éditeur de texte (ex: ${GREEN}Sublime Text${NC})"
            echo "    sur votre système hôte afin de faciliter la compréhension du code."
            echo
            echo_NB
            echo
            cd /home/user2 && su user2
            echo_change_chall
            ;;
        "Social engineering & stéganographie")
            clear
            echo
            echo -e "    Vous allez maintenant être authentifié en tant que ${BLUE}Olivier${NC}"
            echo
            echo "    Votre collègue Olivier ne vous a payé le café ce matin. En faisant sa pause déjeuner, il a oublié"
            echo "    de fermer sa session. Grave erreur ! Faites en sorte qu'il se souvienne de la leçon."
            echo "    Votre but : servez-vous des informations à votre disposition pour obtenir des privilèges sur la session."
            echo
            echo -e "    Vous avez branché une clé USB ${GREEN}USB_KEY${NC} dans laquelle vous pouvez copier des fichiers pour" 
            echo "    les examiner sur votre ordinateur personnel. En réalité, c'est un dossier partagé entre l'image Docker"
            echo "    et la machine hôte, ce qui nous permet de simuler une clé USB. Vous retrouverez ce dossier dans votre"
            echo "    répertoire personnel sous le même nom."
            echo
            echo -e "    Utilisez simplement la commande ${GREEN}cp [fichier à exfiltrer] USB_KEY${NC}"
            echo
            echo_NB
            echo
            cd /home/olivier && su olivier
            echo_change_chall
            ;;
        "Quitter")
            clear
            echo -e -n "${RED}"
            cat /app/aurevoir.aa
            echo -e -n "${NC}"
            sleep 2
            clear
            break
            ;;
        *) echo -e "${RED}Mauvaise saisie${NC}";;
    esac
done