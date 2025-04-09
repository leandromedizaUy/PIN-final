# PIN FINAL diplomatura en DevOps - Ejecución automática con GitHub Actions

Al hacer un `git push` al branch `main` del repositorio de GitHub:

Se ejecutará automáticamente este flujo completo:

## Terraform:
- Inicializa (`terraform init`)
- Aplica (`terraform apply`) y crea:
  - EC2 con Ubuntu y herramientas instaladas (`user_data`)
  - VPC
  - Cluster EKS
  - Node group con 1 nodo

## Configuración del entorno:
- Se instalan `kubectl` y `helm`
- Se genera el `kubeconfig` para acceder al EKS

## Deploy de recursos en Kubernetes:
- Se instala el **EBS CSI driver**
- Se despliega **Prometheus**
- Se despliega **Grafana**
- Se despliega **NGINX** con servicio tipo `LoadBalancer`

---

## Asegurate de tener antes:

✅ Todos los archivos correctamente subidos y con permisos válidos en GitHub

✅ Estos secrets en tu repositorio de GitHub:

| Clave                  | Valor                    |
|------------------------|--------------------------|
| `AWS_ACCESS_KEY_ID`    | Tu Access Key de IAM     |
| `AWS_SECRET_ACCESS_KEY`| Tu Secret Key de IAM     |
| `AWS_REGION`           | `us-east-1`              |
| `EKS_CLUSTER_NAME`     | `eks-mundos-e`           |

---

## ¿Cómo saber si todo funcionó?

1. Andá a la pestaña **Actions** en tu repositorio → seleccioná la ejecución más reciente
2. Esperá ~10 minutos a que se provisionen todos los recursos
3. Entrá a **EC2**, **EKS**, **ELB**, y verificá que los recursos estén activos
4. Buscá las IPs públicas de **Grafana** y **NGINX** en la consola de AWS