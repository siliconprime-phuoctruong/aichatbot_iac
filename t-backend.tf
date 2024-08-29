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
    resource_group_name   = "__Devops_rsgroup__"
    container_name        = "__Container__"
    storage_account_name  = "__Devops_sto__"
    key                   = "__Dev_env_key__"
    access_key            = "__Access_key__"
  }
}

provider "azurerm" {
  features {
    resource_group {
    prevent_deletion_if_contains_resources = false
   }
  }
  subscription_id "__Subscription_id__"
  tenant_id       "__Tenant_id__"
}