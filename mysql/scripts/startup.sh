#!/usr/bin/env bash

# export environment variables
env > /home/vagrant/.env

if [[ ! -d /var/lib/mysql/mysql ]]; then
    if [ ! -f /usr/share/mysql/my-default.cnf ] ; then
        cp /etc/mysql/my.cnf /usr/share/mysql/my-default.cnf
    fi
    mysql_install_db > /dev/null 2>&1

    service mysql start

    mysql -u root -e " \
      UPDATE mysql.user SET password = PASSWORD('$MYSQL_ROOT_PASSWORD') WHERE user = 'root'; FLUSH PRIVILEGES; \
      GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION; FLUSH PRIVILEGES;"

    mysqladmin -uroot -p$MYSQL_ROOT_PASSWORD shutdown
fi

exec mysqld_safe
