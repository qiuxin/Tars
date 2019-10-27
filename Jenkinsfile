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
                sh 'echo Testing ...' 
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying'
                sh 'echo Deploying ...' 
            }
        }
    }
}