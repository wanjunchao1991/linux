#!/bin/bash
yum -y install gcc pcre-devel
cd /opt/
tar -xf /opt/zabbix-3.4.4.tar.gz
cd /opt/zabbix-3.4.4/
./configure --enable-agent
make&&make install
sed -i '93s/Server=127.0.0.1/Server=127.0.01.1,192.168.4.55/' /usr/local/etc/zabbix_agentd.conf
sed -i '118s/# StartAgents=3/StartAgents=0/' /usr/local/etc/zabbix_agentd.conf
sed -i '134s/127.0.0.1/192.168.4.55:10051 /' /usr/local/etc/zabbix_agentd.conf
sed -i "145s/Zabbix server/$HOSTNAME/" /usr/local/etc/zabbix_agentd.conf
sed -i '183s/#//' /usr/local/etc/zabbix_agentd.conf
sed -i '280s/# UnsafeUserParameters=0/UnsafeUserParameters=1/' /usr/local/etc/zabbix_agentd.conf
sed -i '264s/#//' /usr/local/etc/zabbix_agentd.conf
useradd -s /sbin/nologin zabbix 
zabbix_agentd
