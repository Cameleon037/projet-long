#!/bin/bash

apache2ctl start 2> /dev/null > /dev/null
service mysql start 2> /dev/null > /dev/null
mysql -u root --password=root < /app/mogo.sql 2> /dev/null > /dev/null

echo
echo
echo "Bienvenue dans ce tutoriel d'exploitation"
echo "Le but ici est d'obtenir les droits root sur l'image Docker"
echo "Pour parvenir à cette fin, plusieurs exploitations sont possibles"
echo "Nous vous laissons alors le choix entre 3 des plus grandes catégories d'exploitation :"
echo
echo

PS3='Faîtes votre choix :'
options=("Exploitation web de type injection SQL" "Exploitation système de type BufferOverflow" "Ingénierie sociale" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Exploitation web de type injection SQL")
			echo
            echo "Vous allez maintenant être authentifiés en tant que \"user1\""
            echo "Depuis un navigateur sur votre système hôte accédez au site hébergé par ce Docker via l'url : \"localhost:4000\""
            echo "Ce site présente une vulnérabilité, à vous de la trouver et de l'exploiter pour récupérer des informations sensibles"
            echo
            cd /home/user1
            su user1
            break
            ;;
        "Exploitation système de type BufferOverflow")
            echo
            echo "Vous allez maintenant être authentifiés en tant que \"user2\""
            echo "Essayez d'exploiter le binaire \"ageconvertor\" pour obtenir des accès à priori restreints sur le systèmes"
            echo
            cd /home/user2
            su user2
            break
            ;;
        "Ingénierie sociale")
            echo
            echo "Vous allez maintenant être authentifiés en tant que \"user3\""
            echo
            cd /home/user3
            su user3
            break
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done