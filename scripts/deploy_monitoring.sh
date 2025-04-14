#!/bin/bash

set -e

echo "AWS identity:"
aws sts get-caller-identity

echo "Current Kubernetes context:"
kubectl config current-context

echo "Configurando acceso al cluster EKS..."
aws eks update-kubeconfig \
  --region "$AWS_REGION" \
  --name "$EKS_CLUSTER_NAME" \
  --alias default

echo "Confirmar credenciales..."
kubectl config use-context arn:aws:eks:$AWS_REGION:146271912324:cluster/$EKS_CLUSTER_NAME
kubectl get nodes

echo "Instalando Prometheus..."
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/prometheus \
  --namespace monitoring \
  --create-namespace

echo "Instalando Grafana..."
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm install grafana grafana/grafana \
  --namespace monitoring \
  --create-namespace \
  --set service.type=LoadBalancer \
  --set adminPassword='admin123'

echo "Monitoring stack desplegado con éxito"

echo "Esperando IP pública del LoadBalancer de Grafana..."
LB_IP=""
for i in {1..10}; do
  LB_IP=$(kubectl get svc -n monitoring grafana -o jsonpath="{.status.loadBalancer.ingress[0].hostname}")
  if [[ -n "$LB_IP" ]]; then
    break
  fi
  echo "⌛ Aún sin IP... esperando..."
  sleep 10
done

echo "Grafana disponible en: http://$LB_IP"
