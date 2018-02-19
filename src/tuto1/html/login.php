<!doctype html>
<html class="no-js" lang=""> 
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title>MoGo</title>
        <meta name="description" content="">

        <link rel="stylesheet" href="assets/css/font-awesome.min.css">
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/css/style.css">
    </head>
    <body>
        <div class='preloader'></div>
        <div>
            <header id="main_menu" class="header navbar-fixed-top">            
                <div class="main_menu_bg">
                    <div class="container">
                        <div class="row">
                            <nav class="navbar navbar-default">
                                <div class="navbar-header">
                                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                                    <span class="sr-only">Toggle navigation</span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                    </button>
                                    <a class="navbar-brand" href="index.php">
                                        <img src="assets/images/logo.png"/>
                                    </a>
                                </div>

                                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                                    <ul class="nav navbar-nav navbar-right">
                                        <li><a href="index.php">Accueil</a></li>
                                        <li><a href="products.php">Produits</a></li>
                                        <li><a href="login.php">Connexion</a></li>
                                     </ul>
                                </div>

                            </nav>
                        </div>
                    </div>
                </div>
            </header>


            <section>
                <div class="home-overlay">
                    <div class="container">
                        <div class="row">  
                            <div class="col-sm-10 col-sm-offset-1">               
                                <div class="main_device_area text-center">
                                    <div class="row">
                                        <br /><br />
                                        <div class="head_title text-center">
                                            <h4 class="subtitle">Connectez-vous pour gérer votre compte</h4>
                                            <h5>Connexion</h5>
                                            <div class="separator"></div>
                                        </div>

                                        <div>
                                            <?php
                                                if (isset($_POST['login']) and isset($_POST['pass'])) {
                                                    /* Connection à la base de données */
                                                    $connection = mysqli_connect("localhost", "root", "root")
                                                        or print("Could not connect to the database\n");
                                                    mysqli_select_db($connection, "mogodb") or print("Could not select database : " . mysqli_error($connection) . "\n");

                                                    /* Requête SQL simple */
                                                    $query = "SELECT login FROM users WHERE login=? AND pass=?;";
                                                    
                                                    $stmt = mysqli_prepare($connection, $query);
                                                    mysqli_stmt_bind_param($stmt, 'ss', $_POST['login'], $_POST['pass']);

                                                    /* Exécution de la requête */
                                                    mysqli_stmt_execute($stmt);

                                                    /* Lecture des variables résultantes */
                                                    mysqli_stmt_bind_result($stmt, $login);

                                                    /* Récupération des valeurs */
                                                    if(mysqli_stmt_fetch($stmt)) {
                                                        echo "Bienvenue " . $login . " !";
                                                        echo "<br/><br/>";
                                                    }
                                                    else{
                                                        echo "Erreur d'authentification";
                                                    }
                                                
                                                    /* Retour du resultat */
                                                    mysqli_free_result($result);

                                                    /* Fermer la connexion */
                                                    mysqli_close($connection);
                                                }
                                            ?>
                                        </div>

                                        <div class="head_title text-center">
                                            <form class="navbar-form" action="login.php" method=post>
                                                <div class="form-group">
                                                    <input type="login" name="login" placeholder="Login" required>
                                                    <br />
                                                    <input type="password" name="pass" placeholder="Password" required autocomplete="off">
                                                    <br /><br />
                                                    <input type="submit" class="submit_btn" value="Connexion">
                                                </div>
                                            </form>
                                        </div>
                                        <br /><br /><br /><br />
                                        <br /><br /><br /><br />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>


            <footer id="footer" class="footer">
                <div class="container">
                    <div class="main_footer text-center">
                        <div class="row">
                            <div class="col-sm-12 col-xs-12">
                                <div class="copyright_text">
                                    <p>Made with<i class="fa fa-heart"></i>by Wazabis 2018. All Rights Reserved</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </footer>

        </div>

        <script src="assets/js/vendor/jquery-1.11.2.min.js"></script>
        <script src="assets/js/main.js"></script>

    </body>
</html>
