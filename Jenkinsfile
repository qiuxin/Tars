pipeline {
    agent any
    stages {
        stage('InstallBasicLib') {
            steps {
                echo 'Building - Install Basic Lib'
                sh 'echo install -y glibc-devel...'
                sh 'yum install -y glibc-devel'
                sh 'echo install -y flex'
                sh 'yum install -y flex'
                sh 'yum install -y bison'
                sh 'yum install -y cmake'
                sh 'yum install -y ncurses-devel'
                sh 'yum install -y zlib-devel'
                sh 'yum install -y perl'
                sh 'yum install -y wget'
                sh 'yum install -y net-tools'
                sh 'yum install -y gcc'
                sh 'yum install -y gcc-c++'
                sh 'yum install -y make'
                sh 'yum install -y git'
                sh 'yum install -y expect'
                sh 'yum install -y tar'
                sh 'yum install -y epel-release'
                sh 'yum install -y nodejs'
                sh 'yum install -y npm'
                sh 'npm i -g pm2'
                sh 'yum install -y lrzsz'
          }
        }
        stage('CompileMysql') {
            steps {
                echo 'CompileMysql'
                sh 'wget https://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.26.tar.gz'  
                sh 'tar -zxvf mysql-5.6.26.tar.gz -C /usr/local'
                sh 'chown root:root /usr/local/mysql-5.6.26'
                //sh 'ln -s /usr/local/mysql-5.6.26 /usr/local/mysql'
                dir('/usr/local/mysql-5.6.26')
                {
                    sh 'cmake . -DCMAKE_INSTALL_PREFIX=/usr/local/mysql-5.6.26 -DWITH_INNOBASE_STORAGE_ENGINE=1 -DMYSQL_USER=mysql -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci'
                    sh 'make'
                    sh 'make install'
                }
            }
        }
        stage('ConfigMysql') {
            steps {
                dir('/usr/local/mysql')
                {
                    sh 'useradd mysql'  
                    sh 'rm -rf /usr/local/mysql/data'  
                    sh 'mkdir -p /data/mysql-data'
                    sh 'ln -s /data/mysql-data /usr/local/mysql/data'  
                    sh 'chown -R mysql:mysql /data/mysql-data /usr/local/mysql/data'  
                    sh 'cp support-files/mysql.server /etc/init.d/mysql'
                    sh 'yum install -y perl-Module-Install.noarch'
                    sh 'perl scripts/mysql_install_db --user=mysql'
                    
                }  
                echo 'configureMysql successfully'
            }

        //after this stage, configre /usr/local/mysql/my.cnf according to https://github.com/qiuxin/Tars/blob/arm/Install.md
        //after this stage, modify /etc/ld.so.conf and set environment path according to https://github.com/qiuxin/Tars/blob/arm/Install.md
        stage('startMysql') {
            steps {
                sh 'service mysql start'  
                sh 'chkconfig mysql on'
                sh 'mysql --version'  
            }
            echo 'startMysql successfully'
        }
    }
}