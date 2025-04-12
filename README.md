# Proyecto DevOps Mundos E

## Resumen
Proyecto DevOps Mundos E automatiza la creación y destrucción de un clúster AWS EKS usando Terraform, scripts en Shell y GitHub Actions. El proceso permite desplegar la infraestructura y, a través de un workflow, destruir el clúster de forma automática.

## Requisitos
- Cuenta AWS (con permisos adecuados)
- Terraform (v1.10.5)
- CLI: kubectl, jq, eksctl
- Acceso SSH al host remoto

## Variables (Secrets)
- **AWS_ACCESS_KEY_ID**: Clave pública de AWS para acceder a los servicios.
- **AWS_SECRET_ACCESS_KEY**: Clave secreta de AWS para autenticar acciones.
- **PUBLIC_ACCESS_KEY**: Clave pública utilizada para conectarse y controlar el host remoto.
- **EC2_SSH_KEY**: Clave privada SSH para la instancia EC2.
- **EC2_USER**: Usuario SSH para acceder a la instancia EC2.

## Uso

Ejecuta los pipelines de GitHub Actions.