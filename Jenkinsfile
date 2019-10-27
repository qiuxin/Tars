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
        stage('InstallMysql5.6') {
            steps {
                echo 'InstallMysql5.6'
                sh 'cd /usr/local'
                // /root/.jenkins/workspace/My_Pipeline_arm
                sh 'wget https://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.26.tar.gz'
                sh 'pwd'  
                sh 'tar -zxvf mysql-5.6.26.tar.gz -C /usr/local'
                sh 'chown root:root /usr/local/mysql-5.6.26'
                //sh 'ln -s /usr/local/mysql-5.6.26 /usr/local/mysql'
                //sh 'cd /usr/local/mysql-5.6.26'
                //sh 'pwd'
                //sh 'cmake . -DCMAKE_INSTALL_PREFIX=/usr/local/mysql-5.6.26 -DWITH_INNOBASE_STORAGE_ENGINE=1 -DMYSQL_USER=mysql -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci'
                //sh 'make'
                //sh 'make install'
            }
        }
        stage('CompipleTars') {
            steps {
                echo 'CompipleTars'
                //sh 'compile tars ...' 
            }
        }
    }
}