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
    resource_group_name   = "__DevopsResourceGroup__"
    container_name        = "__DevopsContainer__"
    storage_account_name  = "__DevopsStorageAccount__"
    key                   = "__DevenvKey__"
    access_key            = "__StorageAccountKey__"
  }
}

provider "azurerm" {
  features {
    resource_group {
    prevent_deletion_if_contains_resources = false
   }
  }
  subscription_id = "__Subscription_id__"
  tenant_id       = "__Tenant_id__"
}