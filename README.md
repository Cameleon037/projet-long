# Tutoriels d'exploitation web, système et ingénierie sociale/stéganographie

Ce dépôt contient toutes les sources permettant de compiler une image *Docker* à partir de laquelle différents tutoriels vous permettront d'exploiter des vulnérabilités classiques et répandues.


## Installation

### Prérequis

Il convient d'installer *Docker* au préalable pour pouvoir compiler et exécuter l'image *Docker*.

### Commandes à lancer

Deux possibilités s'offrent à vous :

* Vous pouvez télécharger et lancer l'image *Docker* de ce tuto :

```
sudo docker pull tetras037/tuto-exploit
sudo docker run -ti -v $(pwd)/USB_KEY:/home/user3 -p 4000:80 tetras037/tuto-exploit
```


* Ou vous pouvez compiler vous même une image *Docker* avec un nouveau mot de passe *root* arbitraire.
	
	* Il vous faudra tout d'abord clôner ce dépôt git et vous placer dedans.

	```
	git clone https://github.com/Cameleon037/projet-long && cd projet-long
	```
	* Puis vous devrez compiler puis exécuter l'image *Docker*.

	```
	sudo docker build -t tuto-exploit . --build-arg TUTO_PASS=$(cat src/pass.txt)
	sudo docker run -ti -v $(pwd)/USB_KEY:/home/user3 -p 4000:80 tuto-exploit
	```

NB : Le mot de passe *root* peut être modifié dans le fichier *pass.txt*. Il faut également bien penser à rendre inaccessible le code source de cette image (notamment le fichier *pass.txt*) aux challengers !

## Prise en main

Une fois l'image lancée, un menu s'affiche dans votre terminal vous proposant de choisir l'un des trois tutoriels. Vous pouvez donc choisir parmi une exploitation web, une exploitation système (buffer overflow) ou bien de l'ingénierie sociale. Dans chacun des cas, vous arriverez sur le répertoire personnel de l'utilisateur en question et hériterez des privilèges de ces utilisateurs. 

Il vous suffira par la suite de suivre les indications de chaque tutoriel pour mener à bien les exploitations. Bonne chance !