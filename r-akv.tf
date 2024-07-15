#--------------------------------------------------------------------------------------------------------------------
# AZURE KEY VAULT
#--------------------------------------------------------------------------------------------------------------------
module "app_akv" {
  source                          = "./modules/azkv"

  resource_group_name             = local.aks_azrg_name
  location                        = var.location

  akv_name                        = join("", [var.project, var.environment, var.akv_suffixes])
  tenant_id                       = local.tenant_id
  sku_name                        = var.akv_sku_name

  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment
  purge_protection_enabled        = var.purge_protection_enabled
  soft_delete_retention_days      = var.soft_delete_retention_days
  rbac_authorization_enabled      = var.rbac_authorization_enabled
  managed_hardware_security_module_enabled = var.managed_hardware_security_module_enabled
  public_network_access_enabled   = var.public_network_access_enabled
  
  network_acls = {
    bypass         = var.akv_bypass
    default_action = var.akv_default_action
    ip_rules       = concat(var.allowed_cidrs, ["${chomp(data.http.current_public_ip.body)}/32"])

    virtual_network_subnet_ids = [
      local.aks_subnet_id,
      local.be_subnet_id,
      local.appgw_subnet_id
    ]
  }
  admin_objects_ids = [
    module.aks.key_vault_secrets_provider.secret_identity[0].object_id
  ]

  tags       = merge(local.default_tags, var.extra_tags)
}