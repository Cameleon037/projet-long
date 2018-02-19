#!/bin/bash

apache2ctl start 2> /dev/null > /dev/null
service mysql start 2> /dev/null > /dev/null
mysql -u root --password=root < /app/mogo.sql 2> /dev/null > /dev/null
su user1
