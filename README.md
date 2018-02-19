# Tutoriels d'exploitation web, système et ingénierie sociale

Ce dépôt contient toutes les sources permettant de compiler une image *Docker* à partir de laquelle différents tutoriels vous permettront d'exploiter des vulnérabilités classiques et répandues.


## Installation

### Prérequis

Il convient d'installer *Docker* au préalable pour pouvoir compiler et exécuter l'image *Docker*.

### Commandes à lancer

Une fois le dépôt clôné, il suffit simplement de se placer dedans puis de lancer ces deux commandes pour compiler puis exécuter l'image *Docker*.
```
sudo docker build -t TutoExploit .
sudo docker run -ti -p 4000:80 TutoExploit
```

## Prise en main

Une fois l'image lancée, un menu s'affiche dans votre terminal vous proposant de choisir l'un des trois tutoriels. Vous pouvez donc choisir parmi une exploitation web, une exploitation système (buffer overflow) ou bien de l'ingénierie sociale. Dans chacun des cas, vous arriverez sur le répertoire personnel de l'utilisateur en question et hériterez des privilèges de ces utilisateurs. 

Il vous suffira par la suite de suivre les indications de chaque tutoriel pour mener à bien les exploitations. Bonne chance !