<!doctype html>
<html class="no-js" lang=""> 
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title>Mogo free html5 Template</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="apple-touch-icon" href="apple-touch-icon.png">

        <link rel="stylesheet" href="assets/css/font-awesome.min.css">
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">


        <!--For Plugins external css-->
        <link rel="stylesheet" href="assets/css/plugins.css" />

        <!--Theme custom css -->
        <link rel="stylesheet" href="assets/css/style.css">

        <!--Theme Responsive css-->
        <link rel="stylesheet" href="assets/css/responsive.css" />

        <script src="assets/js/vendor/modernizr-2.8.3-respond-1.4.2.min.js"></script>
    </head>
    <body data-spy="scroll" data-target=".navbar-collapse">
        <!--[if lt IE 8]>
            <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
        <![endif]-->
        <div class='preloader'><div class='loaded'>&nbsp;</div></div>
        <div class="culmn">
            <header id="main_menu" class="header navbar-fixed-top">            
                <div class="main_menu_bg">
                    <div class="container">
                        <div class="row">
                            <div class="nave_menu">
                                <nav class="navbar navbar-default">
                                    <div class="container-fluid">
                                        <!-- Brand and toggle get grouped for better mobile display -->
                                        <div class="navbar-header">
                                            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                                                <span class="sr-only">Toggle navigation</span>
                                                <span class="icon-bar"></span>
                                                <span class="icon-bar"></span>
                                                <span class="icon-bar"></span>
                                            </button>
                                            <a class="navbar-brand" href="#home">
                                                <img src="assets/images/logo.png"/>
                                            </a>
                                        </div>

                                        <!-- Collect the nav links, forms, and other content for toggling -->



                                        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">

                                            <ul class="nav navbar-nav navbar-right">
                                                <li><a href="#products">Products</a></li>
                                                <li><a href="#login">Login</a></li>
                                                <li>
                                                    <a href="#"  data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                                                        <i class="fa fa-search"></i>
                                                    </a>
                                                    <ul class="dropdown-menu">
                                                        <li>
                                                            <form class="navbar-form" role="search">
                                                                <div class="form-group">
                                                                    <input type="text" class="form-control" placeholder="Rien à faire ici">
                                                                </div>
                                                            </form>
                                                        </li>
                                                    </ul>
                                                </li>
                                            </ul>


                                        </div>

                                    </div>
                                </nav>
                            </div>	
                        </div>

                    </div>

                </div>
            </header> <!--End of header -->





            <section id="home" class="home">
                <div class="overlay all_overlay">
                    <div class="container">
                        <div class="row">
                            <div class="col-sm-12 ">
                                <div class="main_home_slider text-center">
                                    <div class="single_home_slider">
                                        <div class="main_home wow fadeInUp" data-wow-duration="700ms">
                                            <h4>Creative Template</h4>
                                            <h1>Welcome
                                                to MoGo</h1>

                                            <div class="whiteseparator"></div>
                                            <div class="home_btn">
                                                <a href="" class="btn btn-primary">LEARN MORE</a>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <section id="products" class="products">
                <div class="home-overlay">
                    <div class="container">
                        <div class="row">  
                            <div class="col-sm-10 col-sm-offset-1">               
                                <div class="main_device_area text-center">
                                    <div class="row">
                                        <div class="head_title text-center">
                                            <h4 class="subtitle">Parcourez nos produits</h4>
                                            <h2>Tu trouveras pas mieux ailleurs</h2>
                                            <div class="separator"></div>
                                        </div>

                                        <div class="main_device_content">
                                            <?php

                                                /* Connection à la base de données */
                                                $connection = mysqli_connect("localhost", "root", "root")
                                                    or die("Could not connect to the database\n");
                                                //print "Connected successfully\n";
                                                mysqli_select_db($connection, "test") or die("Could not select database : " . mysqli_error($connection) . "\n");

                                                /* Requête SQL simple */
                                                if (empty($_GET['filter'])) {
                                                    $query = "SELECT * FROM products;";
                                                }
                                                else {
                                                    $query = "SELECT * FROM products WHERE c2='" . $_GET['filter'] . "';";
                                                }
                                                //print($query . "\n");
                                                $result = mysqli_query($connection, $query);

                                                if($result) {
                                                    print "<table>\n";
                                                    while ($line = mysqli_fetch_array($result)) {
                                                        print "\t<tr>\n";
                                                        foreach ($line as $col_value) {
                                                            print "\t\t<td>$col_value</td>\n";
                                                        }
                                                        print "\t</tr>\n";
                                                    }
                                                    print "</table>\n";
                                                }
                                                else{
                                                    print("Query error : " . mysqli_error($connection) . "\n");
                                                }
                                            
                                                /* Retour du résultat */
                                                
                                                mysqli_free_result($result);

                                                /* Fermer la connection */
                                                mysqli_close($connection);
                                            ?>
                                        </div>

                                        <div class="head_title text-center">
                                            <a href="?filter=oui#products">Trier par oui | </a>
                                            <a href="?filter=non#products">Trier par non | </a>
                                            <a href="?#products">Afficher tous</a>
                                            <div class="separator"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <section id="login" class="login">
                <div class="home-overlay">
                    <div class="container">
                        <div class="row">  
                            <div class="col-sm-10 col-sm-offset-1">               
                                <div class="main_device_area text-center">
                                    <div class="row">
                                        <div class="head_title text-center">
                                            <h4 class="subtitle">Connectez-vous pour gérer votre compte</h4>
                                            <h2>Connection</h2>
                                            <div class="separator"></div>
                                        </div>

                                        <div>
                                            <form class="navbar-form navbar-left" action="index.php#login" method=post>
                                                <div class="form-group">
                                                    <input type="login" name="login" placeholder="Login">
                                                    <input type="pass" name="pass" placeholder="Password">
                                                    <input type="submit" class="submit_btn">
                                                </div>
                                            </form>
                                            
                                            <?php
                                                if (isset($_POST['login']) and isset($_POST['pass'])) {
                                                    /* Connection à la base de données */
                                                    $connection = mysqli_connect("localhost", "root", "root")
                                                        or print("Could not connect to the database\n");
                                                    //print "Connected successfully\n";
                                                    mysqli_select_db($connection, "test") or print("Could not select database : " . mysqli_error($connection) . "\n");

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
                                                        print("Vous avez réussi à vous connecter en tant que : " . $login . " félicitations !\n");
                                                    }
                                                    else{
                                                        print("Erreur d'authentification\n");
                                                    }
                                                
                                                    /* Retour du résultat */
                                                    
                                                    mysqli_free_result($result);

                                                    /* Fermer la connection */
                                                    mysqli_close($connection);
                                                }
                                            ?>
                                        </div>

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
                                    <p class=" wow fadeInRight" data-wow-duration="1s">Made with <i class="fa fa-heart"></i> by Wazabis 2018. All Rights Reserved</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </footer>

        </div>

        <!-- START SCROLL TO TOP  -->

        <div class="scrollup">
            <a href="#"><i class="fa fa-chevron-up"></i></a>
        </div>

        <script src="assets/js/vendor/jquery-1.11.2.min.js"></script>
        <script src="assets/js/vendor/bootstrap.min.js"></script>

        <script src="assets/js/jquery.mixitup.min.js"></script>
        <script src="assets/js/jquery.easing.1.3.js"></script>
        <script src="assets/js/jquery.masonry.min.js"></script>
        <script src="assets/js/jquery.fancybox.pack.js"></script>


        <script src="assets/js/plugins.js"></script>
        <script src="assets/js/main.js"></script>

    </body>
</html>