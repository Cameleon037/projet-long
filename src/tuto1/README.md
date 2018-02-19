# Injection SQL


## Synopsis

Avec vos talents de caméraman, vous avez décidé d'acheter une caméra compacte d'une marque toute récente : MoGo. En vous rendant sur leur site Internet, vous commencez à douter de la fiabilité de leur sécurité et voulez tester le site avant d'acheter en ligne votre caméra. Votre but : exploiter une vulnérabilité SQL pour récupérer des informations sensibles !


## Aide à la réalisation

Afin de rendre ce challenge plus pédagogique, vous avez le choix de le réaliser par vous-même (quelques indices sont à disposition au besoin) ou bien en suivant un guide pas à pas. Vous trouverez à la fin la solution détaillée.


### Indices

* Commencer par se connecter au site web...

* Identifier les différents points d'entrée possibles.

* Se rendre compte après avoir perdu du temps sur l'espace de connexion que la vulnérabilité se trouve dans la page *Produits*.

* Essayer d'injecter le paramètre *filter* dans l'URL.

* Si vous n'avez pas deviné les noms des champs et de la table à exploiter, utiliser la table *information_schema*.

* Si vous n'arrivez pas à exploiter correctement la vulnérabilité, utilisez une injection SQL basée sur un *UNION*


### Guide pas à pas

Rendez-vous sur votre machine hôte et lancez un navigateur. Dans la barre d'URL, tapez *localhost:4000*. Vous atterrissez sur le site de MoGo. Prenez le temps de visiter le site et de visualiser les différentes fonctionnalités qu'il offre.

Vous avez un espace de connexion et un espace permettant de lister les différents produits, selon certains critères donnés en entrée. Si vous voulez vous acharner sur l'espace de connexion, vous le pouvez mais ce n'est pas là qu'est orienté ce tutoriel.

Dans l'espace *Produits*, vous pouvez cliquer sur les différents filtres du tableau et voir les changements dans la barre d'URL que cela engendre. 

Les mots *filter* et *order* remarqués plus tôt laissent à penser qu'il y a une interaction avec la base de données utilisée pour afficher les différents produits. Vous avez maintenant le choix d'essayer d'injecter l'une des deux variables.

La variable à injecter est la variable *filter*. Cette variable permet de récupérer de nombreuses informations présentes dans la base de données. Essayez par vous-même d'obtenir ces informations.

Si vous n'avez pas réussi à deviner le nom de la table utilisée et/ou les noms des champs en question, alors il faut procéder autrement. 

Dans un premier temps, il faut que vous retrouviez le nom de la table à utiliser. Pour cela, aidez-vous de la table *information_schema* contenant des informations sur la base de données. Pour cela, utilisez une injection SQL basée sur un *UNION*.

Une fois le nom de la table retrouvé, il faut trouver les noms des différents champs, toujours grâce à la table *information_schema*.

Enfin, une fois la table et les champs retrouvés, il ne reste plus qu'à extraire les informations sensibles !

## Solution

Il faut tout d'abord lancer sur la machine hôte un navigateur et se connecter à *localhost:4000*. 

On arrive ensuite sur le site de MoGo, sur lequel on retrouve un espace de connexion et un espace dédié aux produits. L'espace de connexion n'est pas l'objectif de ce tutoriel et la vulnérabilité a été placée dans l'espace dédié aux produits. 

Dans cet espace, vous trouverez un tableau descriptif des différents produits. Ce tableau manipule la base de données avec les différents filtres applicables. On peut voir deux paramètres à utiliser dans une requête *POST* (à écrire directement dans l'URL). Le paramètre injectable est le paramètre *filter*.

Maintenant que l'on a le point d'entrée de l'injection SQL, il ne reste plus qu'à trouver les noms des tables et des champs utilisés. Pour cela, vous pouvez soit essayer de deviner les noms des tables et champs utilisés, soit rechercher ces informations grâce à différentes injections. Une solution serait de faire les injections suivantes.

Il s'agit dans un premier temps de trouver le nom de la base de données où pourrait se situer les informations sensibles.
```
localhost:4000/products.php?filter=' UNION SELECT schema_name, null, null FROM information_schema.schemata where 'a'='a
```

Il s'agit ensuite de trouver la table à exploiter dans cette base de données.
```
localhost:4000/products.php?filter=' UNION SELECT table_schema, table_name, null FROM information_schema.tables where table_schema='mogodb
```

Il faut maintenant trouver les champs qu'il faut exploiter.
```
localhost:4000/products.php?filter=' UNION SELECT table_schema, table_name, column_name FROM information_schema.columns where table_schema='mogodb' AND table_name = 'users
```

On a maintenant tout ce qu'il nous faut pour faire la dernière exploitation afin de récupérer les mots de passe de tous les utilisateurs.
```
localhost:4000/products.php?filter=' UNION SELECT login, pass, null FROM users where 'a' = 'a
```

On est maintenant en possession du mot de passe de la session *root*, bien joué !