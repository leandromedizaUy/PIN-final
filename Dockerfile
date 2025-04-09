FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV K3S_KUBECONFIG_OUTPUT=/output/kubeconfig.yaml
ENV K3S_KUBECONFIG_MODE=644

# Instalar paquetes base necesarios
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y curl wget unzip gnupg lsb-release \
    software-properties-common apt-transport-https ca-certificates \
    vim git sudo

# Instalar kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -sL https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/ && \
    kubectl version --client

# Instalar Helm
RUN curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Instalar Terraform
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/hashicorp.list && \
    apt-get update && apt-get install terraform -y

# Descargar e instalar minikube
RUN curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \\
    sudo install minikube-linux-amd64 /usr/local/bin/minikube


# Exponer puertos útiles
EXPOSE 6443 3000 9090

# Iniciar k3s y dejar el contenedor corriendo
CMD ["sh", "-c", "minikube start"]
