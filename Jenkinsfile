
pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
                echo 'Source code checked out successfully'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh '''
                    python3 -m venv .venv
                    .venv/bin/python -m pip install -r deployment/requirements.txt
                '''
            }
        }

        stage('Health Check') {
            steps {
                sh 'bash scripts/health_check.sh'
            }
        }

        stage('Unit Testing') {
            steps {
                sh '.venv/bin/python -m pytest tests/ -v'
            }
        }

        stage('Deployment') {
            steps {
                sh '''
                    mkdir -p deployment/output

                    echo "Application deployed successfully" > deployment/output/deployment.txt

                    cat deployment/output/deployment.txt
                '''
            }
        }
    }

    post {
        success {
            echo 'ALL PIPELINE STAGES COMPLETED SUCCESSFULLY!'
        }

        failure {
            echo 'PIPELINE FAILED. CHECK CONSOLE OUTPUT.'
        }
    }
}
