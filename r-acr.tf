module "acr" {
  for_each  = toset(var.app_services)
  source    = "./modules/azacr"

  #name                      = join("", [var.project, var.environment, each.key, random_id.id.hex])
  name                      = join("", [var.project, var.environment, each.key])
  resource_group_name       = local.aks_azrg_name
  location                  = var.location
  sku                       = var.acr_sku
  admin_enabled             = var.admin_enabled
  quarantine_policy_enabled = var.quarantine_policy_enabled
  retention_policy = {
    days    = 5
    enabled = true
  }

  roles = [
    {
      ppal_id = data.azurerm_client_config.current_config.object_id
      role    = "AcrImageSigner"
    },
    {
      ppal_id = module.aks.kubelet_identity[0].object_id
      role    = "Contributor"
    }
  ]
}