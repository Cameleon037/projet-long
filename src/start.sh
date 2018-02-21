#!/bin/bash

echo "pass : $TUTO_PASS"
echo
echo "+--------------------------------------------+"
echo "| Bienvenue dans ce tutoriel d'exploitation  |"
echo "+--------------------------------------------+"
echo
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
			echo
            echo "Vous allez maintenant être authentifiés en tant que \"user1\""
            echo
            echo "Depuis un navigateur sur votre système hôte accédez au site hébergé par ce "
            echo "Docker via l'url : \"localhost:4000\""
            echo
            echo "Ce site présente une vulnérabilité de type injection SQL, à vous de la trouver"
            echo "et de l'exploiter pour récupérer des informations sensibles"
            echo
            apache2ctl start 2> /dev/null > /dev/null
			service mysql start 2> /dev/null > /dev/null
			mysql -u root --password=$TUTO_PASS < /app/mogo.sql 2> /dev/null > /dev/null
			echo "USE mogodb; INSERT INTO users VALUES ('Admin', '$TUTO_PASS');" | mysql -u root --password=$TUTO_PASS 2> /dev/null > /dev/null
			unset TUTO_PASS
            cd /home/user1
            su user1
            break
            ;;
        "Exploitation système de type BufferOverflow")
            echo
            echo "Vous allez maintenant être authentifiés en tant que \"user2\""
            echo
            echo "Essayez d'exploiter le binaire \"ageconvertor\" pour obtenir des accès à"
            echo "priori restreints sur le systèmes"
            echo
            echo "$TUTO_PASS" > /home/user2/passwd.txt
            unset TUTO_PASS
            cd /home/user2
            su user2
            break
            ;;
        "Ingénierie sociale")
            echo
            echo "Vous allez maintenant être authentifiés en tant que \"user3\""
            echo
            unset TUTO_PASS
            cd /home/user3
            su user3
            break
            ;;
        "Quitter")
            break
            ;;
        *) echo invalid option;;
    esac
done