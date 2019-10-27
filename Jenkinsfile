pipeline {
    agent any
    stages {
        stage('InstallBasicLib') {
            steps {
                echo 'Building - Install Basic Lib'
                sh 'echo install -y glibc-devel...'
                sh 'yum install -y glibc-devel'
          }
        }
        stage('Test') {
            steps {
                echo 'Testing'
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