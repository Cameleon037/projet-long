# Ingénierie sociale & stéganographie


## Synopsis

Votre collègue Olivier ne vous a payé le café ce matin. En faisant sa pause déjeuner, il a oublié de fermer sa session. Grave erreur !
La vengeance est un plat qui se mange froid... faites qu'il se souvienne de la leçon. 
Votre but : servez-vous des informations à votre disposition pour obtenir des privilèges sur la session.


## Aide à la réalisation

Afin de rendre ce challenge plus pédagogique, vous avez le choix de le réaliser par vous-même (quelques indices sont à disposition au besoin) ou bien en suivant un guide pas à pas. Vous trouverez à la fin la solution détaillée.

NB: pour ouvrir une photo, utilisez la commande 
```
open nomdufichier
```

### Indices

* Lire le brouillon du mail et identifiez les informations importantes.

* Analyser la photo mise en pièce jointe.

* Retrouver le format du mot de passe IniTech des employés puis celui du destinataire du mail.


### Guide pas à pas

Une fois sur la session de votre collègue Olivier, regardez ce qui se trouve sur son bureau. Vous devriez tomber sur le brouillon d'un mail adressé à un collègue d'IniTech. En le lisant, vous remarquerez que le mot de passe de la session administrateur de son ordinateur portable a été caché afin que ce collègue le retrouve. Il s'agit maintenant de le retrouver.

Dans ce mail, vous verrez également une pièce jointe. Vous vous doutez que cette photo n'est pas anodine et qu'elle cache quelque chose. Il va maintenant falloir l'analyser. Il existe plusieurs méthodes : utiliser des outils dédiés, examiner le dump hexadécimal ou afficher les caractères ascii de la photo. L'une de ces méthodes devrait vous apporter des informations supplémentaires.

Après avoir compris que la photo cache un fichier *zip*, vous essayez de décompresser l'archive. Malheureusement, quelque chose vous bloque...

Vous vous souvenez cependant dans le mail qu'Olivier a laissé un indice concernant ce mot de passe. Par curiosité, vous allez donc lire la charte informatique.

Après avoir trouvé le format du mot de passe, vous devez trouver les informations nécessaires à la décompression de l'archive. Vous avez pour cela à disposition un organigramme d'IniTech.

Vous êtes normalement en mesure d'ouvrir le *.zip* et de récupérer le mot de passe de la session administrateur !


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

signifie que le mot de passe attendu pour la décompression est le même que celui utilisé chez IniTech. En lisant la charte informatique, vous trouvez le format du mot de passe : les 5 premières lettres du prénom suivies du nom, en espérant fortement que ce format par défaut n'a pas été changé (l'erreur est humaine).

Il ne vous reste plus qu'à trouver l'identité du destinataire : l'adresse mail ainsi que l'organigramme suffisent à trouver l'information manquante.
```
open organigramme.jpg
```

```
[selfie.jpg] passwd.txt password: stephberlier
```

En lisant le contenu du fichier *passwd.txt*, vous êtes maintenant en possession du mot de passe de la session *root*, bien joué !