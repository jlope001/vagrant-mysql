FROM       centos:centos6
MAINTAINER Jose Lopez "jlope001@gmail.com"

# setup base programs
RUN yum install -y wget

RUN wget http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm
RUN yum localinstall -y mysql-community-release-el6-5.noarch.rpm
RUN yum install -y mysql-community-server

RUN chown -R mysql:mysql /var/lib/mysql

VOLUME ["/var/lib/mysql"]

EXPOSE 3306

ADD ./scripts/startup.sh /opt/startup.sh
CMD ["/bin/bash", "/opt/startup.sh"]
