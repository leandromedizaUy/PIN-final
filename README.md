# DevOps Lab Setup

Este repositorio proporciona los pasos detallados para configurar un entorno de laboratorio DevOps utilizando Docker, Kubernetes (K3s), Terraform, Prometheus y Grafana.

## Paso a paso detallado

### 1. Crear el docker-compose y el Dockerfile

El contenedor se instala con las siguientes herramientas:

- kubectl
- helm
- terraform
- k3s (reemplazo de EKS)

### 2. Cómo construir y correr este contenedor

Primero, construye y levanta el contenedor con:

```bash
docker-compose up --build -d
```

Luego, ingresa al contenedor:

```bash
docker exec -it devops-lab bash
```

### 3. Aplicar Terraform

Inicializa Terraform y aplica la configuración:

```bash
terraform init
terraform apply -auto-approve
```

Se define en Terraform:

- Namespace de Prometheus y Grafana
- Configuración de Helm charts
- Despliegue de NGINX

### 4. Verificar NGINX

Usa los siguientes comandos para verificar el acceso a NGINX:

```bash
kubectl get pods
kubectl port-forward <nginx-pod-name> 8080:80
```

Accede a NGINX desde el navegador en `http://localhost:8080`.

### 5. Monitoreo con Prometheus y Grafana

Port-forward Prometheus y Grafana:

```bash
kubectl port-forward svc/prometheus-server -n prometheus 9090:80
kubectl port-forward svc/grafana -n grafana 3000:80
```

Accede a Grafana en [http://localhost:3000](http://localhost:3000).

- **Usuario**: admin
- **Contraseña**: la que se configura en Helm

Importa los dashboards 3119 y 6417 desde Grafana (son públicos).

### 6. Cleanup

Para borrar todo con Terraform, ejecuta:

```bash
terraform destroy
```
