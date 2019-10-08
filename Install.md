[点我查看中文版](Install.zh.md)  
  
# Content  
> * [Note Well](#chapter-1)  
> * [Environments](#chapter-2)  
> * [Install Lib](#chapter-3)  
> * [Install Mysql](#chapter-4)  
> * [Install NVM](#chapter-5)  
> * [Download and Compile TarsFramework](#chapter-6)
> * [Install TarsFramework](#chapter-7) 
> * [Initialize Database](#chapter-8)  


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
yum install -y flex
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
source
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

Update the mysql path if errors occured in the process of compile tars:

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
/usr/local/mysql
./bin/mysqladmin -u root password 'root@appinside'
```


Login Mysql:
```
mysql -u root -proot@appinside

```


Setup User and Password:
```
mysql> set global validate_password_policy=0;
mysql> set global validate_password_length=1;
mysql> set password="tars2015";
mysql> grant all on *.* to 'tars'@'%' identified by 'tars2015' with grant option;
mysql> grant all on *.* to 'tars'@'localhost' identified by 'tars2015' with grant option;
mysql> flush privileges;
```





## 6. <a id="chapter-6"></a> Initialize Datebase

### 6.1 Mysql User and Password Setup










## 2.2. Install develop environment for C++  


  
Be aware that the default mysql lib path that Tars use is /usr/local/mysql/ . If mysql is installed in a different path, please modify the files `TarsFramework/CMakeLists.txt` and `TarsFramework/tarscpp/CMakeLists.txt` directory before compiling. (You might change the mysql paths to:"/usr/include/mysql";"/usr/lib64/mysql")  
  
Recompile if needed.  
``` bash
./build.sh cleanall  
./build.sh all  
```  
  
Change to user root and create the installation directory.  
``` bash 
cd /usr/local  
mkdir tars  
chown ${normal user}:${normal user} ./tars/  
```  
  
Installation:
  
```  bash
cd ${source_folder}/build  
./build.sh install or make install  
```  

**The default install path is /usr/local/tars/cpp。**  
  
If you want to install on different path:  
```  
**modify tarscpp/CMakeLists.txt**  
**modify TARS_PATH in tarscpp/servant/makefile/makefile.tars**  
**modify DEMO_PATH in tarscpp/servant/script/create_tars_server.sh**  
```  
  
## 3. <a id="chapter-3"></a>Initialize the db environment for Tars  
### 3.1. Add user  
```sql  
grant all on *.* to 'tars'@'%' identified by 'tars2015' with grant option;  
grant all on *.* to 'tars'@'localhost' identified by 'tars2015' with grant option;  
grant all on *.* to 'tars'@'${hostname}' identified by 'tars2015' with grant option;  
flush privileges;  
```  
**Attention: Modify ${'localhost'} to real hostname from /etc/hosts.**  
  
### 3.2. Create DB  
Search the ip in the script under `framework/sql`,and replace with the above ip.  
  
```bash  
sed -i "s/192.168.2.131/${your machine ip}/g" `grep 192.168.2.131 -rl ./*`  
sed -i "s/db.tars.com/${your machine ip}/g" `grep db.tars.com -rl ./*`  
sed -i "s/10.120.129.226/${your machine ip}/g" `grep 10.120.129.226 -rl ./*`  
```  
  
Execute  
```  
chmod u+x exec-sql.sh  
./exec-sql.sh  
```  
 
After execution of the script, there will be three databases created: db_tars, tars_stat and tars_property.  
  
- db_tars is the core database for framework, it consists of services info, service templates and service configuration, etc.  
- tars_stat is the database for service monitor data.  
- tars_property is the database for service properties monitor data.  
  
## 4. <a id="chapter-4"></a>Build runtime environment for Tars framework  
  
### 4.1. Packing the basic framework service  
  
  
There are two kinds of framework services:  
One is basic core service (required), must be deployed by yourself.  
The other is basic general service, must be patched by management system.  
  
```  
The basic core services:  
tarsAdminRegistry, tarsregistry, tarsnode, tarsconfig, tarspatch  
The basic general services:  
tarsstat, tarsproperty,tarsnotify, tarslog，tarsquerystat，tarsqueryproperty  
```  
First get the core services package, change to build directory and input:  
``` bash 
make framework-tar  
```  
Framework.tgz will be created in current directory.  
It contains tarsAdminRegistry, tarsregistry, tarsnode, tarsconfig and tarspatch deployment files.  
  
Then make the general service package:  
```  bash
make tarsstat-tar  
make tarsnotify-tar  
make tarsproperty-tar  
make tarslog-tar  
make tarsquerystat-tar  
make tarsqueryproperty-tar  
```  
The patch package can be deploy after the patch of management platform, see details in chapter 4.4.  
  
### 4.2. Install basic core service for framework  
#### 4.2.1. Install basic core service  
  
Change to user root, and create the deploy directory for basic service:  
``` bash
cd /usr/local/app  
mkdir tars  
chown ${normal user}:${normal user} ./tars/  
```  
Copy the framework service package to /usr/local/app/tars/ and unzip:  
``` bash  
cp build/framework.tgz /usr/local/app/tars/  
cd /usr/local/app/tars  
tar xzfv framework.tgz  
```  
  
Modify the configuration file in corresponding conf directory for each service, pay attention  
to modify the ip address to your host's address:  
``` bash  
cd /usr/local/app/tars  
sed -i "s/192.168.2.131/${your_machine_ip}/g" `grep 192.168.2.131 -rl ./*`  
sed -i "s/db.tars.com/${your_machine_ip}/g" `grep db.tars.com -rl ./*`  
sed -i "s/registry.tars.com/${your_machine_ip}/g" `grep registry.tars.com -rl ./*`  
sed -i "s/web.tars.com/${your_machine_ip}/g" `grep web.tars.com -rl ./*`  
```  
Execute tars_install.sh script in directory /usr/local/app/tars/ to start tars framework service:  
```  bash
chmod u+x tars_install.sh  
./tars_install.sh  
```  
**If services are deployed on different machines, you need to deal with tars_install.sh script things manually.**  
  
Deploy management platform and launch web management platform to deploy tarspatch (the management platform and tarspatch must in the same machine), change to user root and execute:  
``` bash
tarspatch/util/init.sh  
```  
**Play attention, after executing of above script, check if rsync alive.**  
  
Deploy tarspatch on management platform.  
Deploy tarsconfig on management platform.  
  
You need to configure monitor for tarsnode by crontab. Ensure that it'll be launched after crash:  
```  
* * * * * /usr/local/app/tars/tarsnode/util/monitor.sh  
```  
  
#### 4.2.2. Install tarsnode before scale up  
  
After success of basic core service installation, if you need to deploy tars-based service on different machine,  
install tarsnode first.  
  
If you only deploy service on a single machine, ignore this section.  
  
The details are similar to those described in last section.  
Change to user root, create the directory for deploy service in, as following:  
``` bash  
cd /usr/local/app  
mkdir tars  
chown ${normal user}:${normal user} ./tars/  
```  
  
Copy the framework service package to /usr/local/app/tars/:  
``` bash  
cp build/framework.tgz /usr/local/app/tars/  
cd /usr/local/app/tars  
tar xzfv framework.tgz  
```  
Modify the configuration file in corresponding conf directory for each service, don't forget  
to modify the ip address to your host's address:  
``` bash  
cd /usr/local/app/tars  
sed -i "s/192.168.2.131/${your_machine_ip}/g" `grep 192.168.2.131 -rl ./*`  
sed -i "s/db.tars.com/${your_machine_ip}/g" `grep db.tars.com -rl ./*`  
sed -i "s/registry.tars.com/${your_machine_ip}/g" `grep registry.tars.com -rl ./*`  
sed -i "s/web.tars.com/${your_machine_ip}/g" `grep web.tars.com -rl ./*`  
```  
``` bash 
chmod u+x tarsnode_install.sh  
tarsnode_install.sh  
```  
  
You need to configure monitor for tarsnode by crontab. Ensure that it'll be launched after crash:

```  
* * * * * /usr/local/app/tars/tarsnode/util/monitor.sh  
```  
  
### 4.3. Install web management system  
  
> The name of the directory where management system source code in is **web**  
>  
You can clone the TarsWeb folder too.  
```  bash
git clone https://github.com/TarsCloud/TarsWeb.git  
```  
Modify the configuration file and change the IP address in the configuration file to the local IP address, as follows:  
```  bash
cd ${install folder}  
sed -i 's/db.tars.com/${your_machine_ip}/g' config/webConf.js  
sed -i 's/registry.tars.com/${your_machine_ip}/g' config/tars.conf  
```  
  
Install web management page dependencies, start web  
```  bash
cd ${install folder}  
npm install --registry=https://registry.npm.taobao.org  
npm run prd  
```  
  
Create log directory  
```  bash
mkdir -p /data/log/tars  
```  

visit the website, input`${your machine ip}:3000` into browser.  
  
![tars](docs/images/tars_web_system_index_en.png)
  
  
### 4.4. Install general basic service for framework  
  
**Tips:There are some *.tgz files under the path of /usr/local/app/TarsFramework/build,such as tarslog.tgz, tarsnotify.tgz and so on. There are the patch package for the following services.  
  
#### 4.4.1 Deploy and patch tarsnotify  
  
By default, tarsnofity is ready when install core basic service:  
  
![tars](docs/images/tars_tarsnotify_bushu_en.png)  
  
Upload patch package：  
  
![tars](docs/images/tars_tarsnotify_patch_en.png)  
  
### 4.4.2 Deploy and patch tarsstat  
  
Deploy message:  
  
![tars](docs/images/tars_tarsstat_bushu_en.png)  
  
Upload patch package：  
  
![tars](docs/images/tars_tarsstat_patch_en.png)  
  
### 4.4.3 Deploy and patch tarsproperty  
  
Deployment message:  
  
![tars](docs/images/tars_tarsproperty_bushu_en.png)  
  
Upload patch package：  
  
![tars](docs/images/tars_tarsproperty_patch_en.png)  
  
#### 4.4.4 Deploy and patch tarslog  
  
Deployment message:  
  
![tars](docs/images/tars_tarslog_bushu_en.png)  
  
Upload patch package：  
  
![tars](docs/images/tars_tarslog_patch_en.png)  
  
### 4.4.5 Deploy and patch tarsquerystat  
  
Deployment message:  
**Pay attention: please select non-Tars protocol, because web platform use json protocol to get service monitor info.**  
  
![tars](docs/images/tars_tarsquerystat_bushu_en.png)  
  
  
Upload patch package：  
  
![tars](docs/images/tars_tarsquerystat_patch_en.png)  
  
#### 4.4.6 Deploy and patch tarsqueryproperty  
  
Deployment message:  
**Pay attention: please select non-Tars protocol, because web platform use json protocol to get service monitor info.**  
  
![tars](docs/images/tars_tarsqueryproperty_bushu_en.png)  
  
  
Upload patch package：  
  
![tars](docs/images/tars_tarsqueryproperty_patch_en.png)  
  
Finally,there are some paths you may need to check for troubleshooting once the system doesn't work as you wish.  
(1) ${TarsWeb}/log  
(2) /usr/local/app/tars/app_log/tars

