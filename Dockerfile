FROM ubuntu

##### Set the working directory to /app
#WORKDIR /app

##### Install any needed packages specified in requirements.txt
RUN apt-get update && apt-get -y install apache2 && rm /var/www/html/index.html

RUN echo "mysql-server mysql-server/root_password password root" | debconf-set-selections \
 && echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections
RUN apt-get --assume-yes install mysql-server libapache2-mod-php php-mysql gcc-multilib

RUN echo "root:root" | chpasswd && useradd -m user1 && useradd -m user2 && useradd -m user3

##### Copy the current directory contents into the container at /
ADD ./src/start.sh /app/start.sh
ADD ./src/challenge1/database.sql /app/database.sql
ADD ./src/challenge1/html /var/www/html
ADD ./src/challenge2/ageConvertor/* /home/user2/

##### Make port 80 available to the world outside this container
EXPOSE 80

##### Define environment variable
#ENV NAME World

##### Run app.py when the container launches
CMD ["/app/start.sh"]
