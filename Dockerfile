FROM ubuntu

#### Première couche longue durant la compilation : mise à jour des paquets et installation des paquets nécessaires pour Apache
RUN apt-get update && apt-get --assume-yes install apache2 libapache2-mod-php php-mysql gcc-multilib zip \
 && rm /var/www/html/index.html

##### Argument définissant le mot de passe ultime du tuto
ARG TUTO_PASS

#### Installation du server MySQL avec le bon mot de passe
#ENV DEBIAN_FRONTEND noninteractive
RUN echo "mysql-server mysql-server/root_password password $TUTO_PASS" | debconf-set-selections \
 && echo "mysql-server mysql-server/root_password_again password $TUTO_PASS" | debconf-set-selections \
 && apt-get --assume-yes install mysql-server

#### Ajout des différents utilisateurs
RUN useradd -m user1 && useradd -m user2 && useradd -m olivier \
 && echo "user1:user1" | chpasswd && echo "user2:user2" | chpasswd && echo "olivier:olivier" | chpasswd && echo "root:$TUTO_PASS" | chpasswd 

##### Copie des fichiers utiles aux challenges
ADD ./src/tuto1/mogo_without_pass.sql /app/mogo_without_pass.sql
ADD ./src/tuto1/html /var/www/html
ADD ./src/tuto2/ageConvertor/* /home/user2/
ADD ./src/tuto3/* /home/olivier/

#### Configuration des droits des utilisateurs et des services nécessaires aux challenges
RUN chown -R user2:user2 /home/user2 && chmod -R 700 /home/user2 && chown -R olivier:olivier /home/olivier && chmod -R 700 /home/olivier \
 && chgrp -R www-data /var/www/html && chmod -R 750 /var/www/html && chmod g+s /var/www/html/index.php \
 && replace mot_de_passe_mysql $TUTO_PASS < /var/www/html/login_without_pass.php > /var/www/html/login.php && rm /var/www/html/login_without_pass.php \
 && replace mot_de_passe_mysql $TUTO_PASS < /var/www/html/products_without_pass.php > /var/www/html/products.php && rm /var/www/html/products_without_pass.php \
 && replace mot_de_passe_mysql $TUTO_PASS < /app/mogo_without_pass.sql > /app/mogo.sql && rm /app/mogo_without_pass.sql \
 && service mysql start 2> /dev/null > /dev/null && mysql -u root --password=$TUTO_PASS < /app/mogo.sql 2> /dev/null > /dev/null \
 \
 && chown root:user2 /home/user2/ageconvertor && chown root:root /home/user2/passwd.txt && chmod 4450 /home/user2/ageconvertor \
 && echo $TUTO_PASS > /home/user2/passwd.txt \
 \
 && echo $TUTO_PASS > /home/olivier/passwd.txt && zip -P stephberlier /home/olivier/passwd.zip /home/olivier/passwd.txt \
 && cat /home/olivier/selfie.jpg /home/olivier/passwd.zip > /home/olivier/selfie.jpg && rm /home/olivier/passwd.txt /home/olivier/passwd.zip


#A déplacer
ADD ./src/start.sh /app/start.sh
ADD ./src/tuto-exploit.aa /app/tuto-exploit.aa
ADD ./src/aurevoir.aa /app/aurevoir.aa

##### Exposition du port 80 pour l'extérieur
EXPOSE 80

##### Lancement du script start.sh au lancement de l'image
CMD ["/app/start.sh"]
