locals {
  default_tags = var.default_tags_enable ? {
    environment = var.environment
    project     = var.project
    owner       = var.owner
  } : {}

  ## Azure Kubernetes Service
  aks_admin  = join("", [var.project, var.environment, random_id.id.hex])
  aks_prefix = join("-", [var.project, var.environment, random_id.id.hex])
  appgw_cidr = !var.use_brown_field_application_gateway && !var.bring_your_own_vnet ? "10.225.0.0/16" : "10.52.1.0/24"
  nodes = {
    for i in range(var.aks_nodepool_count) : "worker${i}" => {
      name                  = substr("worker${i}${random_id.id.hex}", 0, 8)
      vm_size               = var.aks_node_size
      node_count            = var.aks_node_count
      vnet_subnet_id                     = data.terraform_remote_state.shared-infras.outputs.subnet_ids["AICHATBOT-NONPRD-T1-AKS"]
      create_before_destroy = i % 2 == 0
    }
  }

  ## Azure Database for flexible MySQL
  mysql_server   = join("", [var.project, var.environment, random_id.id.hex])
  admin_username = join("", [var.project, var.environment, "admin"])

  ## Data form shared infrastructure
  aks_azrg_name   = data.terraform_remote_state.shared-infras.outputs.azrg_name["aks"]
  aks_subnet_id   = data.terraform_remote_state.shared-infras.outputs.subnet_ids["AICHATBOT-NONPRD-T1-AKS"]
  be_subnet_id    = data.terraform_remote_state.shared-infras.outputs.subnet_ids["AICHATBOT-NONPRD-T1-BE"]
  appgw_id        = data.terraform_remote_state.shared-infras.outputs.appgw_id
  appgw_subnet_id = data.terraform_remote_state.shared-infras.outputs.subnet_ids["AICHATBOT-NONPRD-T1-APPGW"]
  mysql_dns_id  = data.terraform_remote_state.shared-infras.outputs.private_dns_zone_id["privatelink.mysql.database.azure.com"]
}