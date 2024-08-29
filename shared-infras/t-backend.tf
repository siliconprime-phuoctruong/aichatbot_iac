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
    resource_group_name   = "__Devops_rsgroup__"
    container_name        = "__Container__"
    storage_account_name  = "__Devops_sto__"
    key                   = "__shared_infra_key__"
    access_key            = "__Access_key__"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "__Subscription_id__"
  tenant_id       = "__Tenant_id__"
}

