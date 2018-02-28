#!/bin/bash

GREEN='\033[0;32m'
BLUE='\033[1;34m'
RED='\033[0;31m'
NC='\033[0m'

function echo_change_chall {
    clear
    echo -e "${BLUE}Que souhaitez-vous faire à présent ?${NC}"
    echo
    echo "1) Exploitation web de type injection SQL"
    echo "2) Exploitation système de type BufferOverflow"
    echo "3) Ingénierie sociale"
    echo "4) Quitter"
}

function echo_NB {
    echo -e "NB : Vous pouvez toujours changer de challenge une fois celui-ci terminé (ou pas)"
    echo -e "avec le raccourci : ${GREEN}Ctrl+D${NC}"
}

clear
#Création du dossier partagé entre l'hôte et le Docker
chmod -R 777 /home/olivier/USB_KEY

echo -e -n "${RED}"
cat /app/tuto-exploit.aa
echo -e -n "${NC}"
echo
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
            echo -e "${BLUE}Vous allez être authentifié en tant que \"user1\"${NC}"
            echo -e "Veuillez patienter durant le lancement du serveur..."
            apache2ctl start 2> /dev/null > /dev/null
            service mysql start 2> /dev/null > /dev/null
            echo
            echo -e "Depuis un navigateur sur votre système hôte accédez au site hébergé par ce "
            echo -e "Docker via l'url : ${GREEN}localhost:4000${NC}"
            echo
            echo -e "Ce site présente une vulnérabilité de type injection SQL, à vous de la trouver"
            echo -e "et de l'exploiter pour récupérer des informations sensibles"
            echo
            echo_NB
            echo
            cd /home/user1 && su user1
            echo_change_chall
            ;;
        "Exploitation système de type BufferOverflow")
            clear
            echo -e "${BLUE}Vous allez maintenant être authentifié en tant que user2${NC}"
            echo
            echo -e "Essayez d'exploiter le binaire ${GREEN}ageconvertor${NC} pour obtenir des accès qui"
            echo -e "vous sont à priori interdits sur le système"
            echo
            echo -e "Le code source du binaire vous est aussi disponible, il est recommandé de"
            echo -e "le lire dans un éditeur de texte (eg : ${GREEN}sublime text${NC}) sur le système"
            echo -e "hôte pour faciliter la compréhension du code."
            echo
            echo_NB
            echo
            cd /home/user2 && su user2
            echo_change_chall
            ;;
        "Ingénierie sociale")
            clear
            echo -e "${BLUE}Vous allez maintenant être authentifié en tant que Olivier"
            echo
            echo -e "Le but ici est de se venger de ce fameux Olivier qui ne paye pas"
            echo -e "le café au boulot. Il a malheuresement laissé sa session ouverte"
            echo -e "et vous en profitez pour essayer de récupérer ses identifiants.${NC}"
            echo
            echo -e "Un répertoire ${GREEN}USB_KEY${NC} est présent et simule une clé USB que vous avez branchée"
            echo -e "sur son système (le Docker). Ce dossier est en réalité un dossier partagé entre"
            echo -e "le Docker et lê système hôte. Cela permet par exemple d'exfiltrer des images"
            echo -e "pour les visualiser dans le ${GREEN}dossier personnel${NC} de votre machine hôte."
            echo
            echo -e "Utilisez simplement la commande ${GREEN}cp [fichier à exfiltrer] USB_KEY${NC}"
            echo -e "pour exfiltrer les informations nécessaires à votre analyse."
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