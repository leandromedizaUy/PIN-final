provider "kubernetes" {
  config_path = "/output/kubeconfig.yaml"
}

provider "helm" {
  kubernetes {
    config_path = "/output/kubeconfig.yaml"
  }
}