resource "azurerm_role_assignment" "assign" {

principal_id                     = var.aks_principal_id
role_definition_name             = var.role
scope                            = var.aks_vnet_id
skip_service_principal_aad_check = true
}

resource "null_resource" "akscredentials" {

  provisioner "local-exec" {
  command="az aks get-credentials -g ${var.resource_group_name} -n ${var.aks_name} --overwrite-existing"
  }

}

resource "helm_release" "ingress" {

  name             = var.nginx_ingress_name
  repository       = var.nginx_repo
  chart            = var.nginx_chart
  namespace        = var.nginx_namespace
  create_namespace = true

  values     = [
    file("${path.module}/values.yaml")
  ]

  depends_on = [ azurerm_role_assignment.assign, null_resource.akscredentials ]
}