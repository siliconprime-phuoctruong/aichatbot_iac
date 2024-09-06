terraform {
    required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.94.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.6.0"
    }
  }
  backend "azurerm" {
    resource_group_name   = "__DevopsResourceGroup__"
    container_name        = "__DevopsContainer__"
    storage_account_name  = "__DevopsStorageAccount__"
    key                   = "__CommonKey__"
    access_key            = "__StorageAccountKey__"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "__Subscription_id__"
  tenant_id       = "__Tenant_id__"
}

