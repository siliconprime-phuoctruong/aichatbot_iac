data "terraform_remote_state" "shared-infras" {
  backend = "azurerm"
    config = {
      resource_group_name   = "__DevopsResourceGroup__"
      container_name        = "__DevopsContainer__"
      storage_account_name  = "__DevopsStorageAccount__"
      key                   = "__CommonKey__"
      access_key            = "__StorageAccountKey__"
    }
}
data "http" "current_public_ip" {
  url = "http://ipv4.icanhazip.com"
}
data "azurerm_client_config" "current_config" {}

data "azurerm_key_vault" "devops" {
  name                = "aichatbotdevopsvault"
  resource_group_name = "AZRG-AICHATBOT-DEVOPS"
}