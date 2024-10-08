module "aks" {
  source  = "Azure/aks/azurerm"
  version = "9.0.0"

  admin_username            = local.aks_admin
  prefix                    = local.aks_prefix
  resource_group_name       = local.aks_azrg_name
  kubernetes_version        = var.aks_version
  automatic_channel_upgrade = var.aks_upgrade

  agents_pool_name          = join("", ["agent", random_id.id.hex])
  agents_availability_zones = var.aks_agent_zones
  agents_count              = var.aks_agent_count
  agents_max_count          = var.aks_max_count
  agents_max_pods           = var.aks_max_pod
  agents_min_count          = var.aks_min_count
  agents_type               = var.aks_agent_type
  agents_pool_linux_os_configs = [
    {
      transparent_huge_page_enabled = "always"
      sysctl_configs = [
        {
          fs_aio_max_nr               = 65536
          fs_file_max                 = 100000
          fs_inotify_max_user_watches = 1000000
        }
      ]
    }
  ]
  node_pools                          = local.nodes
  azure_policy_enabled                = var.aks_azure_policy_enabled
  enable_auto_scaling                 = var.aks_auto_scaling
  enable_host_encryption              = var.aks_enable_host_encryption
  local_account_disabled              = var.aks_local_account_disabled
  log_analytics_workspace_enabled     = var.aks_log_analytics_workspace_enabled
  net_profile_dns_service_ip          = var.aks_dns_ip
  net_profile_service_cidr            = var.aks_cidr
  network_plugin                      = var.aks_network_plugin
  network_policy                      = var.aks_network_policy
  os_disk_size_gb                     = var.aks_disk_volume
  private_cluster_enabled             = var.aks_private_cluster_enabled
  rbac_aad                            = var.aks_rbac_aad
  rbac_aad_managed                    = var.aks_rbac_aad_managed
  rbac_aad_azure_rbac_enabled         = var.aks_rbac_aad_azure_rbac_enabled
  role_based_access_control_enabled   = var.aks_role_based_access_control_enabled
  key_vault_secrets_provider_enabled  = var.key_vault_secrets_provider_enabled
  secret_rotation_enabled             = var.secret_rotation_enabled
  secret_rotation_interval            = var.secret_rotation_interval
  sku_tier                            = var.aks_sku_tier
  vnet_subnet_id                      = var.bring_your_own_vnet ? local.aks_subnet_id : null

  green_field_application_gateway_for_ingress = var.use_brown_field_application_gateway ? null : {
    name        = "ingress"
    subnet_cidr = local.appgw_cidr
  }
  brown_field_application_gateway_for_ingress = var.use_brown_field_application_gateway ? {
    id        = local.appgw_id
    subnet_id = local.appgw_subnet_id
  } : null
  create_role_assignments_for_application_gateway = var.create_role_assignments_for_application_gateway

  tags = merge(local.default_tags, var.extra_tags)
}

#--------------------------------------------------------------------------------------------------------------------
# ROLE ASSIGNMENT
#--------------------------------------------------------------------------------------------------------------------
module "admin_role" {
  source = "./modules/role_assign"

  aks_principal_id    = data.azurerm_client_config.current_config.object_id
  role                = "Azure Kubernetes Service RBAC Cluster Admin"
  aks_scope           = module.aks.aks_id

  depends_on = [ module.aks ]
}