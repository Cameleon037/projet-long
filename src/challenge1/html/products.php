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
                                        <div class="head_title text-center">
                                            <br /><br />
                                            <h4 class="subtitle">Découvrez nos caméras</h4>
                                            <h5>Vous ne trouverez pas mieux ailleurs</h5>
                                            <div class="separator"></div>
                                        </div>

                                        <div>
                                            <h2>Les caméras MoGo sont une nouvelle génération de caméras ultra-compactes et embarquant des technologies de très grande qualité. De la 4K.60fps à 720p.480fps, vous pourrez utiliser la MoGo partout où vous irez : fluidité des rushs pour vos rides, possibilité de faire des slowmotion jusqu'à 1/16e, etc. Chez MoGo, nous vous assurons que vous serez satisfait, le cas contraire, nous reprendront votre caméra sans problème.
                                            <br /><br />
                                            Nous disposons de deux générations de MoGo. La première génération possède une qualité allant jusqu'à 1080p.60fps. Elle est disponible dans différentes capacités mémoire. Nous avons ajouté la technologie WiFi pour contrôler la MoGo à distance seulement pour la MoGo 64Go. Pour la deuxième génération, la qualité monte à 4K.60fps avec une technologie WiFi disponible pour deux des trois modèles.</h2>
                                        </div>

                                        <div class="separator"></div>
                                        <br /><br />
                                        <div class="main_device_content">
                                            <table>
                                                <tr>
                                                    <th>Caméras</th>
                                                    <th>WiFi</th>
                                                    <th>Prix (en €)</th>
                                                </tr>

                                            <?php
                                                /* Connection à la base de données */
                                                $connection = mysqli_connect("localhost", "root", "root")
                                                    or print("Could not connect to the database\n");
                                                mysqli_select_db($connection, "mogodb") or print("Could not select database : " . mysqli_error($connection) . "\n");

                                                /* Requête SQL */
                                                if (empty($_GET['filter']) && empty($_GET['order'])) {
                                                    $query = "SELECT cameras, wifi, prix FROM products;";
                                                }
                                                else if (isset($_GET['order']) && empty($_GET['filter'])) {
                                                    $query = "SELECT cameras, wifi, prix FROM products ORDER BY prix;";
                                                }

                                                else if (isset($_GET['filter']) && empty($_GET['order'])) {
                                                    $query = "SELECT cameras, wifi, prix FROM products WHERE wifi='" . $_GET['filter'] . "';";
                                                }
                                                else if (isset($_GET['filter']) && isset($_GET['order'])) {
                                                    $query = "SELECT cameras, wifi, prix FROM products WHERE wifi='" . $_GET['filter'] . "' ORDER BY prix;";
                                                }

                                                $result = mysqli_query($connection, $query);

                                                if($result) {
                                                    while ($line = mysqli_fetch_assoc($result)) { 
                                                        echo '<tr>';
                                                        foreach ($line as $col_value) {
                                                            echo '<td>' . $col_value . '</td>';
                                                        }
                                                        echo '</tr>';
                                                    }
                                                }
                                                else{
                                                    print("Query error : " . mysqli_error($connection) . "\n");
                                                }

                                                /* Retour du resultat */
                                                mysqli_free_result($result);
                                                /* Fermer la connexion */
                                                mysqli_close($connection);
                                            ?>

                                            </table>
                                        </div>

                                        <br /><br />
                                        <div class="head_title text-center">
                                            <a href="products.php?filter=oui">Filtrer par WiFi | </a>
                                            <a href="products.php?order=prix">Trier par prix | </a>
                                            <a href="products.php">Afficher tout</a>
                                            <div class="separator"></div>
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
