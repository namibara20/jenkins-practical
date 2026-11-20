pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                echo 'Checking out project source code'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'pip3 install -r deployment/requirements.txt'
            }
        }

        stage('Run Health Check') {
            steps {
                sh 'bash scripts/health_check.sh'
            }
        }

        stage('Run Unit Tests') {
            steps {
                sh 'python3 -m pytest tests/ -v'
            }
        }

        stage('Deployment') {
            steps {
                sh 'mkdir -p deployment/output'
                echo 'Deployment directory created successfully'
            }
        }
    }

    post {
        success {
            echo 'PIPELINE EXECUTED SUCCESSFULLY!'
        }

        failure {
            echo 'PIPELINE FAILED!'
        }
    }
}