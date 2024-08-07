resource "azurerm_role_assignment" "assign" {

principal_id                     = var.aks_principal_id
role_definition_name             = var.role
scope                            = var.aks_vnet_id
skip_service_principal_aad_check = true
}

resource "helm_release" "ingress" {

  name             = var.nginx_ingress_name
  repository       = var.nginx_repo
  chart            = var.nginx_chart
  namespace        = var.nginx_namespace
  create_namespace = true
  values = [
    file("${path.module}/values.yml")
  ]
}