pipeline {
    agent { label 'master' }

    environment {
        AWS_REGION = "us-east-2"   // adjust to your AWS region
        IMAGE_TAG = "${env.BUILD_NUMBER}"
    }

    stages {
        stage('Login to ECR') {
            steps {
                script {
                    sh """
                    aws ecr get-login-password --region $AWS_REGION \
                        | docker login --username AWS --password-stdin $ECR_REPO
                    """
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh """
                    docker build -t $ECR_REPO:latest -t $ECR_REPO:$IMAGE_TAG .
                    """
                }
            }
        }

        stage('Push to ECR') {
            steps {
                script {
                    sh """
                    docker push $ECR_REPO:latest
                    docker push $ECR_REPO:$IMAGE_TAG
                    """
                }
            }
        }
    }
}
