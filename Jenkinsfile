pipeline {

    // Run pipeline on any available Jenkins agent
    agent any

    // Environment variables used across all stages
    environment {

        // AWS credentials stored securely in Jenkins
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')

        // AWS region where Terraform will create resources
        AWS_DEFAULT_REGION    = 'us-east-1'

        // Docker Hub image name (must exist in Docker Hub)
        IMAGE_NAME            = 'jyotics24/terraform-s3'
    }

    stages {

        // =========================================================
        // STAGE 1: Checkout source code from GitHub
        // =========================================================
        stage('Checkout Code') {
            steps {
                // Pull Jenkinsfile, Dockerfile, and Terraform code
                checkout scm
            }
        }

        // =========================================================
        // STAGE 2: Build Docker Image with Terraform
        // =========================================================
        stage('Build Docker Image') {
            steps {
                // Build Docker image using Dockerfile
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        // =========================================================
        // STAGE 3: Push Docker Image to Docker Hub
        // =========================================================
        stage('Push Image to Docker Hub') {
            steps {
                // Login to Docker Hub using Jenkins credentials
                withDockerRegistry(
                    [credentialsId: 'dockerhub-credentials', url: '']
                ) {
                    // Push image to Docker Hub repository
                    sh 'docker push $IMAGE_NAME'
                }
            }
        }

        // =========================================================
        // STAGE 4: Pull Docker Image from Docker Hub
        // (Proves image is available & reusable)
        // =========================================================
        stage('Pull Docker Image') {
            steps {
                // Pull the image that was just pushed
                sh 'docker pull $IMAGE_NAME'
            }
        }

        // =========================================================
        // STAGE 5: Run Terraform inside Docker Container
        // =========================================================
        stage('Run Terraform') {
            steps {
                // Run Terraform from Docker image
                // - Pass AWS credentials
                // - Mount terraform folder
                // - Run terraform init & apply
                sh '''
                docker run --rm \
                  -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
                  -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
                  -e AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION \
                  -v $WORKSPACE/terraform:/terraform \
                  $IMAGE_NAME \
                  sh -c "terraform init && terraform apply -auto-approve"
                '''
            }
        }
    }
}