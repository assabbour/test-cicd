pipeline {
    agent any
    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/assabbour/test-cicd.git'
            }
        }
        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }
        stage('Build Angular Application') {
            steps {
                sh 'npm run build --prod'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t angular-app:latest .'
            }
        }
        stage('Run Docker Container') {
            steps {
                sh """
                docker stop angular-app || true
                docker rm angular-app || true
                docker run -d --name angular-app -p 8081:80 angular-app:latest
                """
            }
        }
    }
    post {
        success {
            echo 'Pipeline executed successfully.'
        }
        failure {
            echo 'Pipeline execution failed.'
        }
    }
}
