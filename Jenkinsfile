pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo 'Building - Install Basic Lib'
                sh 'echo Build Module1 stage ...'
            }
            steps {
                echo 'Building - Install Mysql'
                sh 'echo Build Install Mysql ...'
            }
            steps {
                echo 'Building - Compile'
                
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