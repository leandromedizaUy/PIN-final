🧩 Paso a paso detallado
1. Crear el docker-compose y el Dockerfile
el contenedor se instala con las siguientes herramientas:
kubectl
helm
terraform
k3s (reemplazo de EKS)

2. Cómo construir y correr este contenedor
bash
docker-compose up --build -d

bash
docker exec -it devops-lab bash

Exportar el KUBECONFIG (opcional para ejecutar desde afuera):
bash
export KUBECONFIG=./kubeconfig/kubeconfig.yaml


3. Aplicar Terraform
bash
terraform init
terraform apply -auto-approve

Se define en Terraform:

- Namespace de Prometheus y Grafana

- Configuración de Helm charts

- Despliegue de NGINX

4. Verificar NGINX
Usar kubectl get pods y kubectl port-forward para verificar el acceso a NGINX desde el navegador.

5. Monitoreo con Prometheus y Grafana
Port-forward Prometheus y Grafana:

bash
kubectl port-forward svc/prometheus-server -n prometheus 9090:80
kubectl port-forward svc/grafana -n grafana 3000:80
Accedé a Grafana en http://localhost:3000

Usuario: admin

Contraseña: la que configures en Helm

Importás los dashboards 3119 y 6417 desde Grafana (son públicos).

6. Cleanup
Para borrar todo con Terraform:

bash
terraform destroy
