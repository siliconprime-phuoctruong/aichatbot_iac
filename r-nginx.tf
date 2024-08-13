#--------------------------------------------------------------------------------------------------------------------
# ROLE ASSIGNMENT
#--------------------------------------------------------------------------------------------------------------------
module "nginx_role" {
  source = "./modules/role_assign"

  aks_principal_id    = module.aks.cluster_identity.principal_id
  aks_scope           = local.aks_subnet_id
}

#--------------------------------------------------------------------------------------------------------------------
# AKS ROLE ASSIGNMENT
#--------------------------------------------------------------------------------------------------------------------
module "aks_role" {
  source = "./modules/role_assign"

  aks_principal_id    = data.azurerm_client_config.current_config.client_id
  aks_scope           = module.aks.id
  role = "Azure Kubernetes Service RBAC Cluster Admin"
  depends_on = [ module.aks ]
}

#--------------------------------------------------------------------------------------------------------------------
# NULL RESOURCE
#--------------------------------------------------------------------------------------------------------------------
resource "null_resource" "akscredentials" {

  provisioner "local-exec" {
  command="az aks get-credentials -g ${local.aks_azrg_name} -n ${module.aks.aks_name} --overwrite-existing"
  }

}

#--------------------------------------------------------------------------------------------------------------------
# AKS NGINX INGRESS CONTROLLER
#--------------------------------------------------------------------------------------------------------------------
module "nginx_ingress_controller" {
  source = "./modules/helm-release"

  name                = join("-", [var.project, var.environment, "nginx"])
  repository          = var.nginx_repository
  chart               = var.nginx_chart
  namespace           = var.nginx_namespace
  values              = [ file("./modules/helm-release/values.yaml") ]
  #version             = var.nginx_version
  depends_on          = [ module.aks, module.nginx_role, null_resource.akscredentials ]
}