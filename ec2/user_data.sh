#!/bin/bash
apt update && apt install -y unzip curl docker.io
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip && sudo ./aws/install
curl -o kubectl https://s3.us-east-1.amazonaws.com/amazon-eks/1.27.1/2023-07-05/bin/linux/amd64/kubectl
chmod +x kubectl && mv kubectl /usr/local/bin/
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
mv /tmp/eksctl /usr/local/bin
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash