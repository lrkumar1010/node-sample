pipeline {
    agent { label 'master' }

    environment {
        AWS_REGION = "us-east-2"
        IMAGE_TAG = "${env.BUILD_NUMBER}"
    }

    stages {
        stage('Login to ECR') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'aws-creds', 
                                                 usernameVariable: 'AWS_ACCESS_KEY_ID', 
                                                 passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    sh """
                    aws ecr get-login-password --region $AWS_REGION \
                        | docker login --username AWS --password-stdin $ECR_REPO
                    """
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh """
                docker build -t $ECR_REPO:latest -t $ECR_REPO:$IMAGE_TAG .
                """
            }
        }

        stage('Push to ECR') {
            steps {
                sh """
                docker push $ECR_REPO:latest
                docker push $ECR_REPO:$IMAGE_TAG
                """
            }
        }
    }
}
