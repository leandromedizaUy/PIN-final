pipeline {
    agent any
    stages {
        stage('Deploy NGINX') {
            steps {
                sh 'kubectl apply -f k8s/nginx-deployment.yaml'
            }
        }
        stage('Install EBS CSI Driver') {
            steps {
                sh 'kubectl apply -k "github.com/kubernetes-sigs/aws-ebs-csi-driver/deploy/kubernetes/overlays/stable/?ref=release-1.20"'
            }
        }
        stage('Install Prometheus') {
            steps {
                sh '''
                helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
                helm repo update
                kubectl create namespace prometheus
                helm install prometheus prometheus-community/prometheus --namespace prometheus \
                    --set alertmanager.persistentVolume.storageClass="gp2" \
                    --set server.persistentVolume.storageClass="gp2"
                '''
            }
        }
        stage('Install Grafana') {
            steps {
                sh '''
                kubectl create namespace grafana
                helm repo add grafana https://grafana.github.io/helm-charts
                helm repo update
                helm install grafana grafana/grafana --namespace grafana \
                    --set persistence.storageClassName="gp2" \
                    --set persistence.enabled=true \
                    --set adminPassword='EKS!sAWSome' \
                    --values k8s/grafana-values.yaml \
                    --set service.type=LoadBalancer
                '''
            }
        }
    }
}