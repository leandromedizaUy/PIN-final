#!/bin/bash

set -e

echo "Configurando acceso al cluster EKS..."
aws eks update-kubeconfig \
  --region "$AWS_REGION" \
  --name "$EKS_CLUSTER_NAME"

echo "Verificando herramientas..."
kubectl version --client
helm version

echo "Aplicando manifiesto de NGINX..."
kubectl apply -f ~/k8s/manifiesto_nginx.yml --validate=false

echo "Instalando Ingress Controller con Helm..."
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install ingress-nginx ingress-nginx/ingress-nginx \
  --namespace ingress-nginx \
  --create-namespace

echo "Aplicando reglas de ingreso para NGINX..."
kubectl apply -f ~/k8s/ingress_rules.yml

echo "Instalando Prometheus..."
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
