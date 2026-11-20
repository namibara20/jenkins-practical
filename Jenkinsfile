
pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
                echo 'Source code downloaded from GitHub'
            }
        }

        stage('Build') {
            steps {
                echo 'BUILD: Preparing Flask application'

                sh '''
                    python3 -m venv .venv
                    .venv/bin/python -m pip install -r deployment/requirements.txt
                '''

                echo 'BUILD COMPLETED SUCCESSFULLY'
            }
        }

        stage('Test') {
            steps {
                echo 'TEST: Checking project files'
                sh 'bash scripts/health_check.sh'

                echo 'TEST: Running Flask application unit tests'
                sh '.venv/bin/python -m pytest tests/ -v'

                echo 'ALL TESTS PASSED'
            }
        }

        stage('Deploy') {
            steps {
                echo 'DEPLOY: Starting Flask application'

                sh '''
                    mkdir -p deployment/output

                    if [ -f deployment/flask.pid ]; then
                        kill $(cat deployment/flask.pid) 2>/dev/null || true
                    fi

                    nohup .venv/bin/python -m flask --app app.app run --host=127.0.0.1 --port=5000 > deployment/flask.log 2>&1 &

                    echo $! > deployment/flask.pid

                    .venv/bin/python - <<'PY'
import time
import urllib.request

url = "http://127.0.0.1:5000/health"

for attempt in range(15):
    try:
        response = urllib.request.urlopen(url, timeout=2)
        print("Flask application response:", response.status)
        print("DEPLOYMENT SUCCESSFUL")
        break
    except Exception:
        time.sleep(2)
else:
    raise Exception("Flask application failed to start")
PY
                '''

                echo 'FLASK APPLICATION DEPLOYED'
            }
        }
    }

    post {
        success {
            echo 'BUILD, TEST AND DEPLOY COMPLETED SUCCESSFULLY!'
        }

        failure {
            echo 'PIPELINE FAILED. CHECK CONSOLE OUTPUT.'
        }
    }
}
