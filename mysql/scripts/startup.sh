!#!/usr/bin/env bash

# export environment variables
env > /home/vagrant/.env

/etc/init.d/mysql start
sleep 5

mysql -u root -e " \
  UPDATE mysql.user SET password = PASSWORD('$MYSQL_ROOT_PASSWORD') WHERE user = 'root'; FLUSH PRIVILEGES; \
  GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION; FLUSH PRIVILEGES;"

/etc/init.d/mysql stop

exec mysqld_safe
