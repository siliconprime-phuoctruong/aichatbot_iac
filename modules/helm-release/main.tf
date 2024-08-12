resource "helm_release" "ingress" {

  name             = var.name
  repository       = var.repository
  chart            = var.chart
  namespace        = var.namespace
  create_namespace = var.create_namespace
  #version          = var.version
  
  values           = var.values
}