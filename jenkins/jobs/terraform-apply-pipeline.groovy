pipeline {
    agent any
    environment {
        AWS_REGION = "us-east-1"
    }
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/tu-repo/proyecto-devops.git', branch: 'main'
            }
        }
        stage('Install Terraform') {
            steps {
                sh '''
                curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
                sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
                sudo apt-get update && sudo apt-get install terraform -y
                '''
            }
        }
        stage('Terraform Init') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                }
            }
        }
        stage('Terraform Plan') {
            steps {
                dir('terraform') {
                    sh 'terraform plan'
                }
            }
        }
        stage('Terraform Apply') {
            steps {
                dir('terraform') {
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }
}
    