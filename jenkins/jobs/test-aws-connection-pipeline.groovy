pipeline {
    agent any
    stages {
        stage('Verificar credenciales AWS') {
            steps {
                sh 'aws sts get-caller-identity'
            }
        }
        stage('Listar instancias EC2') {
            steps {
                sh 'aws ec2 describe-instances --query "Reservations[*].Instances[*].[InstanceId,State.Name]" --output table'
            }
        }
    }
}