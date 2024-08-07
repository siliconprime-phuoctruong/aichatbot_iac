#--------------------------------------------------------------------------------------------------------------------
# AKS NGINX INGRESS CONTROLLER
#--------------------------------------------------------------------------------------------------------------------
module "nginx_ingress" {
  source = "./modules/nginx-ingress"

  nginx_ingress_name = join("-", [var.project, var.environment, "nginx"])
  aks_principal_id   = module.aks.cluster_indentity.principal_id
  aks_vnet_id        = local.aks_subnet_id

  depends_on         = [ module.aks ]
}