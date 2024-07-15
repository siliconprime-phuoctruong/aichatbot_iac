data "terraform_remote_state" "shared-infras" {
  backend = "azurerm"
    config = {
      resource_group_name   = "AZRG-AICHABOT-DEVOPS"
      container_name        = "tfstate"
      storage_account_name  = "aichatbotdevopssto"
      key                   = "dev-shared-infras.tfstate"
      access_key            = "cCaWYs8mogeUm0Eq8Z9XYo0GQYDC94GW43awByrCYsEQNLmf8WNIk4fHu9sf/cNLOlw36n88RyE8+AStB4GWUw=="
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