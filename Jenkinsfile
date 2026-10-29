pipeline {
    agent any

    triggers {
        pollSCM('H/5 * * * *')
    }

    environment {
        IMAGE_NAME = 'kainaddinov-asset-student-api'
        IMAGE_TAG = 'v1.0-kainaddinov-asset'
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Student: Asset Kainaddinov'
                checkout scm
            }
        }

        stage('Build') {
            steps {
                sh 'chmod +x gradlew'
                sh './gradlew clean bootJar --no-daemon'
            }
        }

        stage('Test') {
            steps {
                sh './gradlew test --no-daemon'
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .'
            }
        }

        stage('Verify') {
            steps {
                sh 'docker image inspect ${IMAGE_NAME}:${IMAGE_TAG}'
                echo 'Verification successful for Asset Kainaddinov'
            }
        }
    }

    post {
        success {
            echo 'SUCCESS: Asset Kainaddinov Student API pipeline completed.'
        }
        failure {
            echo 'FAILURE: Check the stage and console output.'
        }
    }
}
