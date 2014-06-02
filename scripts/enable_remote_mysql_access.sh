#!/bin/bash

mysql -uroot -pnewpassword < "/vagrant/scripts/enable_remote_mysql_access.sql"
sed -i "s/^bind-address/#bind-address/" /etc/mysql/my.cnf
sudo service mysql restart
