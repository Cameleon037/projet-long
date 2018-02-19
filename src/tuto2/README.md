# Buffer Overflow


## Synopsis

Pour vous amuser, vous venez de télécharger un petit programme rédigé en C qui vous permet de calculer votre âge en donnant votre date de naissance. Ce programme étant écrit par un développeur anonyme, vous doutez de la sécurité associée. Votre but : exploiter une vulnérabilité du programme pour obtenir un shell root !


## Aide à la réalisation

Afin de rendre ce challenge plus pédagogique, vous avez le choix de le réaliser par vous-même (quelques indices sont à disposition au besoin) ou bien en suivant un guide pas à pas. Vous trouverez à la fin la solution détaillée.


### Indices

* Identifier le bit *set-user-ID-on-execution* (ou *bit S*) sur le binaire.

* Identifier où et comment se fait l'appel au shell administrateur.

* Regarder l'ordre des variables locales de la fonction RejouerEnregistrer pour voir si un *overflow* est possible.

* Regarder le nombre de caractères effectivement récupérés par le *fgets*.

* Écraser la variable *admin* et la remplacer par la valeur permettant d'obtenir le shell administrateur.


### Guide pas à pas

Une fois connecté en tant que *user2*, vous avez face à vous un espace de travail. Il convient avant tout de regarder ce qui s'y trouve déjà. Vous trouverez donc un binaire (l'exécutable grâce auquel vous pourrez calculer votre âge à partir de votre date de naissance), le code source rédigé en C ayant servi à compiler ce binaire ainsi qu'un fichier texte *passwd.txt* contenant à priori un mot de passe. 

Il convient ensuite de regarder les droits et propriétaires des différents fichiers. Vous pouvez voir d'une part que vous n'avez pas accès au fichier de mot de passe et d'autre part que le binaire possède le bit *set-user-ID-on-execution* (ou *bit S*), qui s'exécute donc avec les privilèges *root*. 

Lancez maintenant le binaire et prenez en main l'application. N'hésitez pas à tester tout type de réponse (pas forcément des chiffres, oui ou non) pour évaluer la robustesse du programme.

Si vous avez remarqué quelques comportements suspects, il est maintenant temps d'aller jeter un oeil au code source. 

Votre but étant d'obtenir un shell administrateur, vous avez sûrement remarqué qu'une fonction *ShellAdministrateur* est invoquée lorsque vous rentrez le bon mot de passe lors de l'enregistrement de vos résultats. Il s'agit donc d'exploiter une vulnérabilité pour faire croire au programme que vous avez le bon mot de passe administrateur pour accéder au shell administrateur.

Pour cela, examinez la fonction *RejouerEnregistrer*. Avez-vous remarqué l'ordre des variables locales ? Avez-vous remarqué les paramètres passés au *fgets* ?
Comme vous l'avez sûrement compris, la fonction *fgets* va lire *TailleEntree* (= 20) caractères tapés au clavier et les mettre dans la variable *buf* qui ne peut en accueillir que 14. Les caractères supplémentaires (si tant est qu'il y en ait) seront donc mis plus loin dans la pile, c'est-à-dire dans la variable *admin* et un bout de la variable *reponse*.

À vous de jouer maintenant pour écraser la variable *admin* et la remplacer par la valeur adéquate afin que vous deveniez root !


## Solution

Le binaire possède le bit *set-user-ID-on-execution*, qui s'exécute donc avec les privilèges *root*. Ça va permettre d'obtenir un shell avec les privilèges adéquats.

On remarque que le *buffer overflow* va s'effectuer dans la fonction *RejouerEnregistrer* car c'est à cet endroit qu'un shell administrateur est ouvert grâce à la fonction *ShellAdministrateur*.

Le buffer *buf* peut contenir jusqu'à 14 caractères alors que la fonction *fgets* va lire jusqu'à 20 caractères passés en entrée au clavier. Les 6 caractères qui ne rentre pas dans le buffer vont donc écraser les variables locales suivantes dans la pile : les variables *admin* et *reponse*. 

On remarque enfin que la variable *admin* doit être mise à *o* pour obtenir un shell administrateur. À partir de là, on comprendre que l'on doit dépasser le buffer et écraser la variable *admin* avec la valeur *o* pour obtenir ce que l'on souhaite. On peut le faire à deux moments dans l'exécution du programme : soit à la première question concernant le rejeu du programme, soit à la seconde concernant l'enregistrement des résultats. En effet, dans les deux cas c'est le même buffer qui est utilisé.

Il faut donc par exemple rentrer la chaîne de caractères suivante (seul le quinzième caractère est important)
```
Voulez-vous rejouer [oui/non] : aaaaaaaaaaaaaao
```

On a maintenant un shell avec les privilèges root qui permet de lire le fichier *passwd.txt* pour obtenir le mot de passe de la session *root* avec la commande
```
cat passwd.txt
```

Bien joué !

