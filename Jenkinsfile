pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "angular-app:latest"
        APP_PORT = "80"
    }
    parameters {
        string(name: 'APP_PORT', defaultValue: '80', description: 'Port sur lequel déployer l’application')
        string(name: 'DOCKER_IMAGE', defaultValue: 'angular-app:latest', description: 'Nom de l’image Docker')
    }
    stages {
        stage('Clean Workspace') {
            steps {
                cleanWs()
            }
        }
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/assabbour/test-cicd.git'
            }
        }
        stage('Check Versions') {
            steps {
                sh 'node -v'
                sh 'npm -v'
                sh 'docker --version'
            }
        }
        stage('Run Tests') {
            steps {
                sh 'npm install'
                sh 'npm test -- --watch=false'
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
        stage('Test Docker Container') {
            steps {
                sh "docker run --rm ${DOCKER_IMAGE} echo 'Container works!'"
            }
        }
        stage('Run Docker Container') {
              steps {
                sh """
                docker stop angular-app || true
                docker rm angular-app || true
                docker run -d --name angular-app -p 8080:80 ${DOCKER_IMAGE}
                """
    }
        }
        stage('Clean Docker') {
            steps {
                sh 'docker system prune -f'
            }
        }
    }
    post {
        success {
            echo 'Deployment successful!'
        }
        failure {
            sh 'docker logs angular-app || true'
            echo 'Deployment failed. Check the container logs.'
        }
    }
}
