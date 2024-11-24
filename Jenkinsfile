pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "angular-app:latest"
        APP_PORT = "8080"
    }
    stages {
        stage('Clean Workspace') {
            steps {
                cleanWs() // Nettoyer l'espace de travail
            }
        }
        stage('Clone Repository') {
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
                sh "docker build -t ${DOCKER_IMAGE} ."
            }
        }
        stage('Run Docker Container') {
            steps {
                sh """
                docker stop angular-app || true
                docker rm angular-app || true
                docker run -d --name angular-app -p ${APP_PORT}:80 ${DOCKER_IMAGE}
                """
            }
        }
        stage('Verify Deployment') {
            steps {
                sh 'docker ps | grep angular-app'
            }
        }
    }
    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Check the logs.'
        }
    }
}
