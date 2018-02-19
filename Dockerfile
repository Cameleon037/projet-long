FROM ubuntu

##### Install any needed packages specified in requirements.txt

RUN echo "mysql-server mysql-server/root_password password FN3Uqm77Abt3" | debconf-set-selections \
 && echo "mysql-server mysql-server/root_password_again password FN3Uqm77Abt3" | debconf-set-selections \
 && apt-get update && apt-get --assume-yes install apache2 mysql-server libapache2-mod-php php-mysql gcc-multilib \
 && rm /var/www/html/index.html

RUN useradd -m user1 && useradd -m user2 && useradd -m user3 \
 && echo "user1:user1" | chpasswd && echo "user2:user2" | chpasswd && echo "user3:user3" | chpasswd && echo "root:FN3Uqm77Abt3" | chpasswd

##### Copy the current directory contents into the container at /
ADD ./src/start.sh /app/start.sh
ADD ./src/tuto1/mogo.sql /app/mogo.sql
ADD ./src/tuto1/html /var/www/html
ADD ./src/tuto2/ageConvertor/* /home/user2/

RUN chown -R user2:user2 /home/user2 && chmod -R 700 /home/user2 && chown -R user3:user3 /home/user3 && chmod -R 700 /home/user3 \
 && chown root:user2 /home/user2/ageconvertor && chown root:root /home/user2/passwd.txt && chmod 4450 /home/user2/ageconvertor

##### Make port 80 available to the world outside this container
EXPOSE 80

##### Run app.py when the container launches
CMD ["/app/start.sh"]
