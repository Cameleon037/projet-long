FROM ubuntu

#### Première couche longue durant la compilation : mise à jour des paquets et installation des paquets nécessaires pour Apache
RUN apt-get update && apt-get --assume-yes install apache2 libapache2-mod-php php-mysql gcc-multilib zip \
 && rm /var/www/html/index.html

##### Argument définissant le mot de passe ultime du tuto
ARG TUTO_PASS

#### Installation du server MySQL avec le bon mot de passe
RUN echo "mysql-server mysql-server/root_password password $TUTO_PASS" | debconf-set-selections \
 && echo "mysql-server mysql-server/root_password_again password $TUTO_PASS" | debconf-set-selections \
 && apt-get --assume-yes install mysql-server

#### Ajout des différents utilisateurs
RUN useradd -m user1 && useradd -m user2 && useradd -m user3 \
 && echo "user1:user1" | chpasswd && echo "user2:user2" | chpasswd && echo "user3:user3" | chpasswd && echo "root:$TUTO_PASS" | chpasswd

##### Copie des fichiers utiles aux challenges
ADD ./src/tuto1/mogo.sql /app/mogo.sql
ADD ./src/tuto1/html /var/www/html
ADD ./src/tuto2/ageConvertor/* /home/user2/
ADD ./src/start.sh /app/start.sh


#### Configuration des droits des utilisateurs et des services nécessaires aux challenges
RUN chown -R user2:user2 /home/user2 && chmod -R 700 /home/user2 && chown -R user3:user3 /home/user3 && chmod -R 700 /home/user3 \
 && chgrp -R www-data /var/www/html && chmod -R 750 /var/www/html && chmod g+s /var/www/html/index.php \
 \
 && chown root:user2 /home/user2/ageconvertor && chown root:root /home/user2/passwd.txt && chmod 4450 /home/user2/ageconvertor \
 && echo $TUTO_PASS > /home/user2/passwd.txt && service mysql start 2> /dev/null > /dev/null \
 && mysql -u root --password=$TUTO_PASS < /app/mogo.sql 2> /dev/null > /dev/null \
 && echo "USE mogodb; INSERT INTO users VALUES ('Admin', '$TUTO_PASS');" | mysql -u root --password=$TUTO_PASS 2> /dev/null > /dev/null \
 \
 && echo $TUTO_PASS > /home/user3/passwd.txt && zip -P stephberlier passwd.zip passwd.txt && cat photo.jpg passwd.zip > selfie.jpg \
 && rm passwd.txt passwd.zip && alias open="xdg-open"


##### Exposition du port 80 pour l'extérieur
EXPOSE 80

##### Lancement du script start.sh au lancement de l'image
CMD ["/app/start.sh"]
