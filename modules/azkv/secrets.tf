resource "azurerm_key_vault_secret" "secrets" {
  key_vault_id  = var.id
  name          = var.name
  value         = var.value
}