# DevOps Lab

Este repositorio contiene un entorno de desarrollo para practicar DevOps utilizando Docker, Terraform, Helm, k3s y herramientas como Prometheus y Grafana.

## Paso a paso detallado

### 1. Crear el Docker Compose y el Dockerfile

El contenedor se instala con las siguientes herramientas:

- kubectl
- helm
- terraform
- k3s (reemplazo de EKS)

### 2. Cómo construir y correr este contenedor

Construir y ejecutar el contenedor:

```bash
docker-compose up --build -d
