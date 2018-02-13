<?php

    /* Connection à la base de données */
    $link = mysqli_connect("localhost", "root", "root")
        or die("Could not connect : " . mysql_error());
    print "Connected successfully";
    mysqli_select_db("test") or die("Could not select database");

    /* Requête SQL simple */
    $query = "SELECT * FROM persons";
    $result = mysqli_query($query)
	or die("Query failed : " . mysql_error());

    /* Retour du résultat */
    print "<table>\n";
    while ($line = mysql_fetch_array($result, MYSQL_ASSOC)) {
        print "\t<tr>\n";
        foreach ($line as $col_value) {
            print "\t\t<td>$col_value</td>\n";
        }
        print "\t</tr>\n";
    }
    print "</table>\n";
    mysqli_free_result($result);

    /* Fermer la connection */
    mysqli_close($link);
?>

