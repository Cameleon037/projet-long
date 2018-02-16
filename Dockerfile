FROM ubuntu

##### Set the working directory to /app
#WORKDIR /app

##### Install any needed packages specified in requirements.txt
RUN apt-get update && apt-get -y install apache2 && rm /var/www/html/index.html

RUN echo "mysql-server mysql-server/root_password password root" | debconf-set-selections
RUN echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections
RUN apt-get -y install mysql-server --assume-yes && apt-get install libapache2-mod-php php-mysql --assume-yes

RUN echo "root:root" | chpasswd && useradd user && useradd user2 && useradd user3
RUN mkdir /var/lib/mysql/test

##### Copy the current directory contents into the container at /
ADD ./src/start.sh /app/start.sh
ADD ./src/challenge1/html /var/www/html
ADD ./src/challenge1/mysql /var/lib/mysql
RUN chown -R mysql:mysql /var/lib/mysql && chmod -R o-xr var/lib/mysql

##### Make port 80 available to the world outside this container
EXPOSE 80

##### Define environment variable
#ENV NAME World

##### Run app.py when the container launches
CMD ["/app/start.sh"]
