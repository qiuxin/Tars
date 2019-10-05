#!/bin/bash


## install mysql 5.7
wget https://repo.mysql.com//mysql80-community-release-el7-3.noarch.rpm
rpm -ivh mysql80-community-release-el7-3.noarch.rpm
yum-config-manager --disable mysql80-community
yum-config-manager --enable mysql57-community
yum install -y mysql-community-server
yum install -y mysql-devel
echo "Finish mysql5.7 installation"

#disable password for mysql
#echo "# disable password">>/etc/my.cnf
#echo "skip-grant-tables">>/etc/my.cnf
#echo "disable password for mysql">>$CodePath/Tars/shellDeploy/deploy_log

## 启动mysql,并设置为开机自启动
## start mysql
systemctl start mysqld.service
systemctl enable mysqld.service
systemctl status mysqld.service
echo "start mysql5.7 ..."
