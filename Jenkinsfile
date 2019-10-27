pipeline {
    agent any
    stages {
        stage('InstallBasicLib') {
            steps {
                echo 'Building - Install Basic Lib'
                sh 'echo Build Module1 stage ...'
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