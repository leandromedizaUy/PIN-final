resource "helm_release" "grafana" {
  name       = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  namespace  = kubernetes_namespace.grafana.metadata[0].name

  set {
    name  = "adminPassword"
    value = "admin123"
  }

  set {
    name  = "persistence.enabled"
    value = "false"
  }

  set {
    name  = "service.type"
    value = "NodePort"
  }
}
