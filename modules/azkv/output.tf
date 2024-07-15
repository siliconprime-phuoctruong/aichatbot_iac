output "keyvault-id" {
  value = azurerm_key_vault.keyvault.id
}

output "keyvault-name" {
  value = azurerm_key_vault.keyvault.name
}

output "keyvault_url" {
  value = azurerm_key_vault.keyvault.vault_uri
}