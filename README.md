# Proyecto Integrador DevOps

Este proyecto crea una infraestructura de bajo costo en AWS para desplegar un clúster EKS, una instancia EC2 con Jenkins, monitoreo con Prometheus y Grafana, y despliegue de una app NGINX.

## Componentes:
- EC2 (t3.nano): Jenkins + herramientas DevOps
- EKS: NGINX, Prometheus, Grafana
- Helm, Terraform, Jenkins, kubectl

## Instrucciones
1. Configurar credenciales AWS
2. Ejecutar Terraform en `terraform/`
3. Conectarse a la EC2 e iniciar Jenkins
4. Correr el pipeline de Jenkins