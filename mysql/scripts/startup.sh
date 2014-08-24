#!/usr/bin/env bash

if [[ ! -d /var/lib/mysql/mysql ]]; then
    if [ ! -f /usr/share/mysql/my-default.cnf ] ; then
        cp /etc/my.cnf /usr/share/mysql/my-default.cnf
    fi
    mysql_install_db > /dev/null 2>&1
fi

chown -R mysql:mysql /var/lib/mysql

service mysqld start

mysql -u root -e " \
  UPDATE mysql.user SET password = PASSWORD('$MYSQL_ROOT_PASSWORD') WHERE user = 'root'; FLUSH PRIVILEGES; \
  GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION; FLUSH PRIVILEGES;"

mysqladmin -uroot -p$MYSQL_ROOT_PASSWORD shutdown

# setup replication
if [ ! -z "MYSQL_DATABASES_REPLICATION_ALLOW" ]; then
  sed -i 's/#server-id/server-id/g' /etc/my.cnf
  sed -i 's/#log_bin/log_bin/g' /etc/my.cnf

  # create replication on all databases
  arr=($MYSQL_DATABASES_REPLICATION_ALLOW)
  for x in $arr
  do
    echo "binlog_do_db = $x" >> /etc/my.cnf
  done
fi
if [ ! -z "MYSQL_DATABASES_REPLICATION_DENY" ]; then
  sed -i 's/#server-id/server-id/g' /etc/my.cnf
  sed -i 's/#log_bin/log_bin/g' /etc/my.cnf

  # ignore replication on all databases
  arr=($MYSQL_DATABASES_REPLICATION_DENY)
  for x in $arr
  do
    echo "binlog_ignore_db = $x" >> /etc/my.cnf
  done
fi

exec mysqld_safe
