FROM ubuntu

##### Install any needed packages specified in requirements.txt

RUN echo "mysql-server mysql-server/root_password password root" | debconf-set-selections \
 && echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections \
 && apt-get update && apt-get --assume-yes install apache2 mysql-server libapache2-mod-php php-mysql gcc-multilib \
 && rm /var/www/html/index.html

RUN useradd -m user1 && useradd -m user2 && useradd -m user3 \
 && echo "user1:user1" | chpasswd && echo "user2:user2" | chpasswd && echo "user3:user3" | chpasswd && echo "root:root" | chpasswd

##### Copy the current directory contents into the container at /
ADD ./src/start.sh /app/start.sh
ADD ./src/challenge1/mogo.sql /app/mogo.sql
ADD ./src/challenge1/html /var/www/html
ADD ./src/challenge2/ageConvertor/* /home/user2/

##### Make port 80 available to the world outside this container
EXPOSE 80

##### Run app.py when the container launches
CMD ["/app/start.sh"]
