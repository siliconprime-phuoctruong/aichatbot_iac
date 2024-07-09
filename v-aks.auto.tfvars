# GENERAL
project      = "aichatbot"
environment  = "dev"
owner        = "allsup"
location     = "eastus"
domain       = ""
app_services = [ "fe", "crm", "core" ]
extra_tags  = {
  "creator"  = "Managed by Terraform"
}

# AZURE KUBERNETES SERVICE
aks_version                         = "1.29"
aks_upgrade                         = "patch"
aks_agent_zones                     = ["1", "2"]
aks_agent_count                     = null
aks_max_count                       = 2
aks_min_count                       = 1
aks_max_pod                         = 100
aks_agent_type                      = "VirtualMachineScaleSets"
aks_azure_policy_enabled            = true
aks_auto_scaling                    = true
aks_enable_host_encryption          = true
aks_local_account_disabled          = false
aks_log_analytics_workspace_enabled = false
aks_dns_ip                          = "10.0.0.0"
aks_cidr                            = "10.0.0.0/16"
aks_network_plugin                  = "azure"
aks_network_policy                  = "azure"
aks_disk_volume                     = 60
aks_private_cluster_enabled         = false
aks_rbac_aad                        = true
aks_rbac_aad_managed                = true
aks_role_based_access_control_enabled = true
aks_sku_tier                          = "Standard"
aks_nodepool_count                    = 1
aks_node_count                        = 1
aks_node_size                         = "Standard_D2s_v3"
use_brown_field_application_gateway   = true
bring_your_own_vnet                   = true

# AZURE CONTAINER REGISTRY
admin_enabled             = true
encryption_enabled        = false
quarantine_policy_enabled = false

# AZURE DATABASE FOR FLEXIBLE MYSQL
mysql_version               = "8.0.21"
mysql_availability_zones    = "2"
mysql_storage_size          = "100"
mysql_sku                       = "GP_Standard_D4ds_v4"
mysql_vnet_integration_enabled  = false
mysql_backup_retention_days     = "30"
mysql_iops                      = "1000"
mysql_auto_grow_enabled         = true
mysql_geo_redundant_enabled     = false
mysql_diagnostics_enabled       = false
mysql_start_ip                  = "10.20.3.0"
mysql_end_ip                    = "10.20.3.255"
db_charset                      = "utf8mb3"
db_collation                    = "utf8mb3_unicode_ci"
db_name                         = [ "aichatbot" ]

