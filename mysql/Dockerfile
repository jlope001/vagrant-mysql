FROM       ubuntu:14.04
MAINTAINER Jose Lopez "jlope001@gmail.com"

# install system
RUN apt-get update

# setup mysql server 5.6
RUN apt-get -y install mysql-server-5.6
RUN sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/my.cnf
# fix /etc/passwd issue with mysql having /nonexistent
RUN sed -i 's~^mysql:\([^:]*\):\([^:]*\):\([^:]*\):\([^:]*\):/nonexistent:\([^:]*\)~mysql:\1:\2:\3:\4:\/var\/lib\/mysql:\5~' /etc/passwd

VOLUME ["/var/lib/mysql"]

EXPOSE 3306

ADD ./scripts/startup.sh /opt/startup.sh
CMD ["/bin/bash", "/opt/startup.sh"]
