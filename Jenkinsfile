// Use any available Jenkins agent/node
agent any

// Define environment variables and credentials
environment {
    // AWS credentials stored securely in Jenkins Credentials Manager
    AWS_ACCESS_KEY_ID     = credentials('aws-access-key')
    AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')

    // AWS region where resources will be created
    AWS_DEFAULT_REGION    = 'us-east-1'

    // Docker image name (Docker Hub repository)
    IMAGE_NAME            = 'jyotics24/terraform-s3'
}

stages {

    // Stage 1: Checkout source code from SCM (Git repository)
    stage('Checkout Code') {
        steps {
            checkout scm
        }
    }

    // Stage 2: Build Docker image containing Terraform configuration
    stage('Build Docker Image') {
        steps {
            // Build Docker image using Dockerfile in repository
            sh 'docker build -t $IMAGE_NAME .'
        }
    }

    // Stage 3: Push Docker image to Docker Hub
    stage('Push Image to Docker Hub') {
        steps {
            // Authenticate with Docker Hub using Jenkins credentials
            withDockerRegistry([credentialsId: 'dockerhub-credentials', url: '']) {
                // Push image to Docker Hub repository
                sh 'docker push $IMAGE_NAME'
            }
        }
    }

    // Stage 4: Run Terraform inside Docker container
    stage('Run Terraform') {
        steps {
            sh '''
            docker run --rm \
              // Pass AWS credentials as environment variables to container
              -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
              -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
              -e AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION \
              // Use the built Docker image
              $IMAGE_NAME \
              // Initialize Terraform and apply configuration automatically
              sh -c "terraform init && terraform apply -auto-approve"
            '''
        }
    }
}