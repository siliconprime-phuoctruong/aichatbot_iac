resource "azurerm_role_assignment" "assign" {

principal_id                     = var.aks_principal_id
role_definition_name             = var.role
scope                            = var.aks_scope
skip_service_principal_aad_check = false
}