terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.94.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.22.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.6.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.9.1"
    }
  }
  backend "azurerm" {
    resource_group_name   = "AZRG-AICHABOT-DEVOPS"
    container_name        = "tfstate"
    storage_account_name  = "aichatbotdevopssto"
    key                   = "dev-environment.tfstate"
    access_key            = "cCaWYs8mogeUm0Eq8Z9XYo0GQYDC94GW43awByrCYsEQNLmf8WNIk4fHu9sf/cNLOlw36n88RyE8+AStB4GWUw=="
  }
}

provider "azurerm" {
  features {
    resource_group {
    prevent_deletion_if_contains_resources = false
   }
  }
  subscription_id = "85c60575-b3f1-4078-8788-5e150fb84555"
  tenant_id       = "b3dc8175-7891-4b01-9e44-8e18fa4277f0"
}