FROM projet-long

# Set the working directory to /app
#WORKDIR /app

# Copy the current directory contents into the container at /app
ADD ./src/start.sh /app/start.sh

# Install any needed packages specified in requirements.txt
#RUN apt-get update && apt-get -y install apache2

#RUN echo "mysql-server mysql-server/root_password password root" | debconf-set-selections
#RUN echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections
#RUN apt-get -y install mysql-server --assume-yes

#RUN echo "root:root" | chpasswd
#RUN useradd user && useradd user2 && useradd user3



# Make port 80 available to the world outside this container
EXPOSE 80

# Define environment variable
#ENV NAME World

# Run app.py when the container launches
CMD ["/app/start.sh"]
