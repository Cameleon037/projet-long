# Ingénierie sociale & stéganographie


## Synopsis

Votre collègue Olivier ne vous a payé le café ce matin. En faisant sa pause déjeuner, il a oublié de fermer sa session. Grave erreur !
Faites en sorte qu'il se souvienne de la leçon. 
Votre but : servez-vous des informations à votre disposition pour obtenir des privilèges sur la session.


## Aide à la réalisation

Afin de rendre ce challenge plus pédagogique, vous avez le choix de le réaliser par vous-même (quelques indices sont à disposition au besoin) ou bien en suivant un guide pas à pas. Vous trouverez à la fin la solution détaillée.

NB: vous avez branché une clé USB dans laquelle vous pouvez copier des fichiers pour les examiner sur votre ordinateur personnel. En réalité, c'est un dossier partagé entre l'image Docker et la machine hôte, ce qui nous permet de simuler une clé USB. Utilisez la commande suivante pour copier vos fichiers.
```
cp fichier_à_copier USB_KEY
```

### Indices

* Lire le brouillon du mail et identifiez les informations importantes.

* Analyser la photo mise en pièce jointe.

* Retrouver le format du mot de passe IniTech des employés puis celui du destinataire du mail.


### Guide pas à pas

Une fois sur la session de votre collègue Olivier, regardez ce qui se trouve sur son bureau. Vous devriez tomber sur le brouillon d'un mail adressé à un collègue d'IniTech. En le lisant, vous remarquerez que le mot de passe de la session administrateur de son ordinateur portable a été caché afin que ce collègue le retrouve. Il s'agit maintenant de le retrouver.

Dans ce mail, vous verrez également une pièce jointe. Vous vous doutez que cette photo n'est pas anodine et qu'elle cache quelque chose. Il va maintenant falloir l'analyser. Il existe plusieurs méthodes : utiliser des outils dédiés, examiner le dump hexadécimal ou afficher les caractères ascii de la photo (avec la fonction **strings**). L'une de ces méthodes devrait vous apporter des informations supplémentaires. 

Après avoir compris que la photo cache un fichier *txt*, vous essayez d'extraire ce fichier, une simple décompression devrait suffire. Malheureusement, quelque chose vous bloque... un mot de passe est requis.

Vous vous souvenez cependant qu'Olivier a laissé dans le mail un indice concernant ce mot de passe. Par curiosité, vous allez donc lire la charte informatique (préalablement importée dans votre ordinateur personnel grâce à la clé USB).

Après avoir trouvé le format du mot de passe, vous devez trouver les informations nécessaires à la décompression de l'archive. Vous avez pour cela à disposition un organigramme d'IniTech. Vous espérez fortement qu'Olivier n'a pas changé son mot de passe par défaut depuis son entrée dans la boîte... mais vous le savez maladroit et êtes optimiste.

Vous devriez désormais être en mesure d'extraire le fichier *txt* de l'image et de récupérer le mot de passe de la session administrateur !


## Solution

En lisant le mail, vous comprenez que le mot de passe de la session *root* est caché quelque part. La photo en pièce jointe est suspecte. En affichant les caractères ascii de la photo, vous apprenez que la photo cache un fichier *passwd.txt*.
```
strings selfie.jpg
```

Pour extraire ce fichier, une simple décompression suffit.
```
unzip selfie.jpg
```

Un mot de passe vous est alors demandé pour extraire le fichier *passwd.txt*. 
En relisant le mail, vous comprenez que la phrase
> c'est comme à la boîte

signifie que le mot de passe attendu pour la décompression est le même que celui utilisé chez IniTech. En lisant la charte informatique (préalablement importée avec les autres photos en faisant `cp *.jpg USB_KEY`), vous trouvez le format du mot de passe : les 5 premières lettres du prénom suivies du nom, en espérant fortement que ce format par défaut n'a pas été changé (l'erreur est humaine).

Il ne vous reste plus qu'à trouver l'identité du destinataire : l'adresse mail ainsi que l'organigramme suffisent à trouver l'information manquante.
```
[selfie.jpg] passwd.txt password: stephberlier
```

En lisant le contenu du fichier *passwd.txt*, vous êtes maintenant en possession du mot de passe de la session *root*, bien joué !