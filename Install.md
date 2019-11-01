# Table of contents(Arm Platform)  
> * [Note Well](#chapter-1)  
> * [Environments](#chapter-2)  
> * [Install Lib](#chapter-3)  
> * [Install Mysql](#chapter-4)  
> * [Install NVM](#chapter-5)  
> * [Download and Compile TarsFramework](#chapter-6)
> * [Install TarsFramework](#chapter-7) 
> * [Initialize Database](#chapter-8)  
> * [Start TarsFramework Services](#chapter-9)  
> * [Install Tarsweb](#chapter-10)  
> * [Compile TarsFramework NoneCore Service](#chapter-11)  
> * [Visit web](#chapter-12)  

## 1. <a id="chapter-1"></a> Note Well
This document describes the steps to deploy, run, and test Tars framework.

This is the arm verion install process, some steps are different to X86 platform.
Make sure you are run Tars on ARM platform prior to follow the instructions itemized below.  
  
## 2. <a id="chapter-2"></a> Environments   
System : CentOS 7  
Hardware requirements: aarch64 Arm Server  
  
## 3. <a id="chapter-3"></a> Install Libs 
  
Install all the libs that will be used in the process of intstalltion.

```  
yum install -y glibc-devel
yum install -y flex
yum install -y bison
yum install -y cmake
yum install -y ncurses-devel
yum install -y zlib-devel
yum install -y perl
yum install -y wget
yum install -y net-tools
yum install -y gcc
yum install -y gcc-c++
yum install -y make
yum install -y git
yum install -y expect
yum install -y tar
yum install -y epel-release
yum install -y nodejs
yum install -y npm
npm i -g pm2
yum install -y lrzsz
```  

## 4. <a id="chapter-3"></a> Install Mysql

### 4.1 Version
Only MYsql 5.6,5.7 are supported in Tars Platform.

### 4.1 Install mysql via yum
Mysql 5.6, 5.7 yum installation are NOT supported by Oracle yet. It is NOT avaliale.

### 4.2 Install mysql via source code
So the ONLY way to install mysql is source code.

#### 4.2.1 Donwload/Install/Compile Mysql  
Donwload/Install/Compile the source code of mysql5.6.
```
cd /usr/local
wget https://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.26.tar.gz
tar -zxvf mysql-5.6.26.tar.gz
chown root:root ./mysql-5.6.26
ln -s /usr/local/mysql-5.6.26 /usr/local/mysql
cd mysql-5.6.26
cmake . -DCMAKE_INSTALL_PREFIX=/usr/local/mysql-5.6.26 -DWITH_INNOBASE_STORAGE_ENGINE=1 -DMYSQL_USER=mysql -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci
make
make install
```
Tars souce code can be compiled successfully after the foregoing mysql was installed successfully

#### 4.2.2 Congfig Mysql 
Configure Mysql
```
cd /usr/local/mysql  
useradd mysql  
rm -rf /usr/local/mysql/data  
mkdir -p /data/mysql-data  
ln -s /data/mysql-data /usr/local/mysql/data  
chown -R mysql:mysql /data/mysql-data /usr/local/mysql/data  
cp support-files/mysql.server /etc/init.d/mysql  
yum install -y perl-Module-Install.noarch  
perl scripts/mysql_install_db --user=mysql  
```


Update the parameters in /usr/local/mysql/my.cnf
```
[mysqld]  
  
# Remove leading # and set to the amount of RAM for the most important data  
# cache in mysql. Start at 70% of total RAM for dedicated server, else 10%.  
innodb_buffer_pool_size = 128M  
  
# Remove leading # to turn on a very important data integrity option: logging  
# changes to the binary log between backups.  
log_bin  
  
# These are commonly set, remove the # and set as required.  
basedir = /usr/local/mysql  
datadir = /usr/local/mysql/data  
# port = .....  
# server_id = .....  
socket = /tmp/mysql.sock  
  
bind-address=${your machine ip}  
  
# Remove leading # to set options mainly useful for reporting servers.  
# The server defaults are faster for transactions and fast SELECTs.  
# Adjust sizes as needed, experiment to find the optimal values.  
join_buffer_size = 128M  
sort_buffer_size = 2M  
read_rnd_buffer_size = 2M  
  
sql_mode=NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES  
```

#### 4.2.3 Start Mysql

After that, you can start mysql and stop mysql successfully.

Start mysql  
```
service mysql start  
chkconfig mysql on  
```

Stop mysql  
```
service mysql stop  
```  


#### 4.2.4 Add Mysql lib

Add the mysql lib in the conf file(/etc/ld.so.conf):
```
vim /etc/ld.so.conf  
```
add the following line
```
/usr/local/mysql/lib/  
```
then run
```
ldconfig  
```


#### 4.2.5 Setup the environment path
```
vim /etc/profile  
```
Add the following path to /etc/profile  
```
PATH=$PATH:/usr/local/mysql/bin  
export PATH  
```
then run
```
source /etc/profile
```
Check mysql verion to make sure everything goes well. 
```
mysql --version
```


## 5. <a id="chapter-5"></a> Install NVM

```
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
source ~/.bashrc
nvm install v8.11.3
npm install -g pm2
```


## 6. <a id="chapter-6"></a> Download and Compile TarsFramework
download and compile code
```
git clone -b arm https://github.com/qiuxin/Tars.git
cd ${download_path}/Tars
git submodule update --init --recursive
cd ${download_path}/Tars/TarsFramework/build
chmod u+x build.sh 
./build.sh all
```

In case you want rebuild 
```
./build.sh cleanall  
./build.sh all 
```

Update the mysql path if errors occured in the process of compiling Tars:

Mofified Files:
```
/usr/local/TarsFramework/tarscpp/CMakeLists.txt
/usr/local/TarsFramework/CMakeLists.txt
```


Modified Details from:
```
set(MYSQL_DIR_INC  "/usr/local/mysql/include")
set(MYSQL_DIR_LIB   "/usr/local/mysql/lib")
```
to
```
set(MYSQL_DIR_INC  "/usr/include/mysql")
set(MYSQL_DIR_LIB  "/usr/lib64/mysql")
```

if the forgoing path is still NOT right , use the following command to figure out the rigth path:
```
find / -name libmysqlclient.a
find / -name mysql.h
```



## 7. <a id="chapter-7"></a> Install TarsFramework

```
cd /usr/local/
mkdir tars
chown root:root ./tars/
cd ${download_path}/Tars/framework/build/
./build.sh install
```


## 8. <a id="chapter-8"></a> Initialize Datebase

### 8.1 modify IP address

```
cd ${download_path}/Tars/framework/sql
sed -i "s/192.168.2.131/${MachineIp}/g" `grep 192.168.2.131 -rl ./*`
sed -i "s/db.tars.com/${MachineIp}/g" `grep db.tars.com -rl ./*`
sed -i "s/10.120.129.226/${MachineIp}/g" `grep 10.120.129.226 -rl ./*`
```
${MachineIp} is local IP address. Check IP address via ipconfig.




### 8.1 Setup User and Password

Establish the new password for mysql
```
cd /usr/local/mysql
service mysql start
./bin/mysqladmin -u root password 'tars2015'
```


Login Mysql:
```
mysql -u root -ptars2015
```

Setup User and Password:
```
mysql> install plugin validate_password soname 'validate_password.so';
mysql> set global validate_password_policy=0; 
mysql> set global validate_password_length=1; 
mysql> set password="tars2015"; (Not work, SET old_passwords = 0,1,2; does not help! )
mysql> grant all on *.* to 'tars'@'%' identified by 'tars2015' with grant option;
mysql> grant all on *.* to 'tars'@'localhost' identified by 'tars2015' with grant option;
mysql> grant all on *.* to 'tars'@'${hostname}' identified by 'tars2015' with grant option;
mysql> flush privileges;
```
To get your hostname in CentOS7,
```
# hostname
ip-32-31-7-45.us-east-6.compute.internal
```

### 8.2 Create Datebase
Login Mysql:
```
mysql -u root -ptars2015
```

create datebases
```
create database db_tars;
create database tars_stat;
create database tars_property;
create database db_tars_web;
```

check the datebases you created
```
show databases;
```


### 8.3 Import Datebase Tables

Enter the path:
```
cd ${download_path}/Tars/framework/sql
```

Login Mysql:
```
mysql -u root -ptars2015
```

Import datebases tables:
```
use db_tars;
source db_tars.sql
source tarslog.sql
source tarsstat.sql
source tarsproperty.sql
source tarsqueryproperty.sql
source tarsquerystat.sql
```


## 9. <a id="chapter-9"></a> Start TarsFramework Services
Compile
```
cd ${download_path}/Tars/framework/build
make framework-tar
cd /usr/local
mkdir app
cd /usr/local/app/
mkdir tars
chown root:root ./tars/
cd tars/
cp ${download_path}/Tars/framework/build/framework.tgz /usr/local/app/tars/
cd /usr/local/app/tars/
tar -zxvf framework.tgz
```

Replace the IP adress
```
cd /usr/local/app/tars
sed -i "s/192.168.2.131/${MachineIp}/g" `grep 192.168.2.131 -rl ./*`
sed -i "s/db.tars.com/${MachineIp}/g" `grep db.tars.com -rl ./*`
sed -i "s/registry.tars.com/${MachineIp}/g" `grep registry.tars.com -rl ./*`
sed -i "s/web.tars.com/${MachineIp}/g" `grep web.tars.com -rl ./*`
```
${MachineIp} is the server's IP address which can grab via ifconfig. 


Start Tarsframework Services
```
cd /usr/local/app/tars/
chmod u+x tars_install.sh
./tars_install.sh
```

## 10. <a id="chapter-10"></a> Install TarsWeb
### 10.1 Config Tarsweb database
```
cd ${download_path}/Tars/web/
sed -i "s/db.tars.com/${MachineIp}/g" config/webConf.js
sed -i "s/registry.tars.com/${MachineIp}/g" config/tars.conf
```

### 10.2 Install tarsweb software
```
npm install --registry=https://registry.npm.taobao.org
npm run prd
```


### 10.3 Import mysql table

Enter the folder and log in mysql
```
cd ${download_path}/TarsWeb/sql
mysql -u root -ptars2015
```

Import the table
```
use db_tars_web;
source db_tars_web.sql
exit
```

### 10.4 pm2 start
```
cd $CodePath/Tars/web/
pm2 start 0
```

### 10.5 shutdown firewall
shutdown firewall
```
service firewalld status
systemctl stop firewalld
systemctl disable firewalld
```

## 11. <a id="chapter-11"></a> Compile TarsFramework and Deploy NoneCore Service
```
cd ${download_path}/Tars/framework/build
make tarsstat-tar
make tarsnotify-tar
make tarsproperty-tar
make tarslog-tar
make tarsquerystat-tar
make tarsqueryproperty-tar
```

## 12. <a id="chapter-11"></a> Visit web
Visit IP:3000 in the web:
![image](https://github.com/qiuxin/Tars/blob/arm/Picture/tarsframe.PNG)


## 13. <a id="chapter-11"></a> Multiple Server Deployment
Note well:  Tarsweb and TarsPatch services are ONLY avaliable to deploy in one physical server.

### 13.1 Install basic in new server
Install all the libs that will be used in the process of intstalltion.
```
yum install -y glibc-devel
yum install -y flex
yum install -y bison
yum install -y cmake
yum install -y ncurses-devel
yum install -y zlib-devel
yum install -y perl
yum install -y wget
yum install -y net-tools
yum install -y gcc
yum install -y gcc-c++
yum install -y make
yum install -y git
yum install -y expect
yum install -y tar
yum install -y epel-release
yum install -y nodejs
yum install -y npm
npm i -g pm2
yum install -y lrzsz
```

### 13.2 Download/Compile Mysql Code in new Server

Download the mysql source code and compile it
```
cd /usr/local
wget https://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.26.tar.gz
tar -zxvf mysql-5.6.26.tar.gz
chown root:root ./mysql-5.6.26
ln -s /usr/local/mysql-5.6.26 /usr/local/mysql
cd mysql-5.6.26
cmake . -DCMAKE_INSTALL_PREFIX=/usr/local/mysql-5.6.26 -DWITH_INNOBASE_STORAGE_ENGINE=1 -DMYSQL_USER=mysql -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci
make
make install
```

### 13.3 Download/Compile Tars Code in new Server
Download the mysql source code and compile it
```
git clone -b arm https://github.com/qiuxin/Tars.git
cd ${download_path}/Tars
git submodule update --init --recursive
cd ${download_path}/Tars/TarsFramework/build
chmod u+x build.sh 
./build.sh all
```

### 13.4 Install TarsFramwork in new server
```
cd /usr/local/
mkdir tars
chown root:root ./tars/
cd ${download_path}/Tars/framework/build/
./build.sh install
```

### 13.5 Compile TarsFramework.tgz and Replace IP address in new server
Compile
```
cd ${download_path}/Tars/framework/build
make framework-tar
cd /usr/local
mkdir app
cd /usr/local/app/
mkdir tars
chown root:root ./tars/
cd tars/
cp ${download_path}/Tars/framework/build/framework.tgz /usr/local/app/tars/
cd /usr/local/app/tars/
tar -zxvf framework.tgz
```

Replace the IP address
```
cd /usr/local/app/tars
sed -i "s/192.168.2.131/${MachineIp}/g" `grep 192.168.2.131 -rl ./*`
sed -i "s/db.tars.com/${MachineIp}/g" `grep db.tars.com -rl ./*`
sed -i "s/registry.tars.com/${MachineIp}/g" `grep registry.tars.com -rl ./*`
sed -i "s/web.tars.com/${MachineIp}/g" `grep web.tars.com -rl ./*`
${MachineIp} is the server's IP address which can grab via ifconfig.
```

### 13.6 Start tarsregistry services in new server
Modify Locator of configure file
```
vim /usr/local/app/tars/tarsregistry/conf/tars.tarsregistry.config.conf
```

Update the locator in tars.tarsregistry.config.conf
- 10.11.6.13 is the New Server IP address.
- 10.11.6.11 is the master Server IP address in which Tars has already been installed successfully.
```
 locator                     = tars.tarsregistry.QueryObj@tcp -h 10.11.6.13 -p 17890:tcp -h 10.11.6.11 -p 17890
```

Update the dbhost in tars.tarsregistry.config.conf
- 10.11.6.11 is the master Server IP address in which mysql has already been installed successfully.
```
dbhost  = 10.11.6.11
```

Start tarsregistry Services
```
cd /usr/local/app/tars/
chmod u+x ./tarsregistry/util/start.sh
./tarsregistry/util/start.sh
```

### 13.7 Start tarsAdminRegistry services in new server
Modify Locator of configure file
```
vim /usr/local/app/tars/tarsAdminRegistry/conf/tars.tarsAdminRegistry.config.conf
```

Update the locator in tars.tarsregistry.config.conf
- 10.11.6.13 is the New Server IP address.
- 10.11.6.11 is the master Server IP address in which Tars has already been installed successfully.
```
  locator=tars.tarsregistry.QueryObj@tcp -h 10.11.6.13 -p 17890:tcp -h 10.11.6.11 -p 17890
```

Update the dbhost in tars.tarsregistry.config.conf
- 10.11.6.11 is the master Server IP address in which mysql has already been installed successfully.
```
  dbhost=10.11.6.11
```

Start tarsAdminRegistry Services
```
cd /usr/local/app/tars/
chmod u+x ./tarsAdminRegistry/util/start.sh
./tarsAdminRegistry/util/start.sh
```

### 13.8 Start tarsnode services in new server
Modify Locator of configure file
```
cd /usr/local/app/tars/
vim ./tarsnode/util/execute.sh
```

Update the locator in execute.sh
- 10.11.6.13 is the New Server IP address.
- 10.11.6.11 is the master Server IP address in which Tars has already been installed successfully.
```
  $bin --locator="tars.tarsregistry.QueryObj@tcp -h 10.11.6.13 -p 17890:tcp -h 10.11.6.11 -p 17890" --config=/usr/local/app/tars/tarsnode/conf/tars.tarsnode.config.conf &
```

Start tarsnode Services
```
cd /usr/local/app/tars/
chmod u+x ./tarsnode/util/start.sh
./tarsnode/util/start.sh
```

### 13.9 Modify locator in "old" server

Modify the locater in tarsregistry(/usr/local/app/tars/tarsregistry/conf/tars.tarsregistry.config.conf)
- 10.11.6.13 is the New Server IP address.
- 10.11.6.11 is the master Server IP address in which Tars has already been installed successfully.
```
locator                     = tars.tarsregistry.QueryObj@tcp -h 10.11.6.11 -p 17890:tcp -h 10.11.6.13 -p 17890
```

Modify the locater in tarsAdminRegistry(/usr/local/app/tars/tarsAdminRegistry/conf/tars.tarsAdminRegistry.config.conf)
- 10.11.6.13 is the New Server IP address.
- 10.11.6.11 is the master Server IP address in which Tars has already been installed successfully.
```
locator=tars.tarsregistry.QueryObj@tcp -h 10.11.6.11 -p 17890:tcp -h 10.11.6.13 -p 17890
```

Modify the locater in tarsnode(/usr/local/app/tars/tarsnode/util/execute.sh)
- 10.11.6.13 is the New Server IP address.
- 10.11.6.11 is the master Server IP address in which Tars has already been installed successfully.
```
$bin --locator="tars.tarsregistry.QueryObj@tcp -h 10.11.6.11 -p 17890:tcp -h 10.11.6.13 -p 17890" --config=/usr/local/app/tars/tarsnode/conf/tars.tarsnode.config.conf &
```


### 13.10 Reboot the service in "old" server

Get rid of all Tars related process
```
ps -aux |grep tars
kill -9 ${$process_id} 
```

Start Tars process again
```
cd /usr/local/app/tars
chmod +x tarsAdminRegistry/util/*.sh
chmod +x tarsconfig/util/*.sh
chmod +x tarsnode/util/*.sh
chmod +x tarspatch/util/*.sh
chmod +x tarsregistry/util/*.sh

./tarsregistry/util/start.sh
./tarsAdminRegistry/util/start.sh
./tarsnode/util/start.sh
./tarsconfig/util/start.sh
./tarspatch/util/start.sh
```
