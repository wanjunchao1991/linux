#!/bin/bash
yum -y install net-snmp-devel curl-devel libevent-devel
cd /opt/Zabbix
tar -xf zabbix-3.4.4.tar.gz
cd zabbix-3.4.4/
./configure --enable-server --enable-agent --with-mysql=/usr/bin/mysql_config --with-net-snmp --with-libcurl
make &&make install
mysql -e "create database zabbix character set utf8"
mysql -e "grant all on zabbix.* to zabbix@'localhost' identified by 'zabbix'"
cd /opt/Zabbix/zabbix-3.4.4 /database/mysql/
mysql -uzabbix -pzabbix zabbix < schema.sql
mysql -uzabbix -pzabbix zabbix < images.sql
mysql -uzabbix -pzabbix zabbix < data.sql
cd /opt/Zabbix/zabbix-3.4.4/frontends/php/
cp -r * /usr/local/nginx/html/
chmod -R ugo=rwx /usr/local/nginx/html/*
yum -y install  php-gd php-xml php-ldap php-bcmath.x86_64  php-mbstring.x86_64 #zabbix监控管理依赖包

