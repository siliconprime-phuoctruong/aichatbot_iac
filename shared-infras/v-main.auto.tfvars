# GENERAL
project     = "__Project__"
environment = "__Environment__"
owner       = "allsup"
location    = "__Location__"
domain      = ""
extra_tags  = {
  "creator"  = "Managed by Terraform"
}

# AZURE RESOURCE GROUP
azrg_suffix      = ["aks", "vnet"]

# AZURE VIRTUAL NETWORK
subnet_suffix       = [ __Subnet_suffix__ ]
address_space       = [ __Address_space__ ]
bgp_community        = null
dns_servers          = ["168.63.129.16"]
ddos_protection_plan = null
use_for_each         = true

subnet_service_endpoints = [
  "Microsoft.Storage.Global",
  "Microsoft.Sql",
  "Microsoft.KeyVault",
  "Microsoft.EventHub",
  "Microsoft.ContainerRegistry",
  "Microsoft.AzureActiveDirectory",
  "Microsoft.AzureCosmosDB",
  "Microsoft.ServiceBus",
  "Microsoft.Web"
]

# AZURE APPLICATION GATEWAY
azgw_suffix             = "ingress"
appgw_allocation_method = "Static"
appgw_sku               = "Standard"
use_brown_field_application_gateway = true
bring_your_own_vnet                 = true

# AZURE PRIVATE DNS ZONE
private_domain = [ "privatelink.mysql.database.azure.com" ]