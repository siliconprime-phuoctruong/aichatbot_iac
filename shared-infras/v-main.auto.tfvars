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
azrg_suffix      = [__Azrg_Suffix__]

# AZURE VIRTUAL NETWORK
subnet_suffix       = [ __Subnet_Suffix__ ]
address_space       = [ __Address_Space__ ]
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
azgw_suffix             = "__Azgw_Suffix__"
appgw_allocation_method = "Static"
appgw_sku               = "__Azgw_Sku__"
use_brown_field_application_gateway = true
bring_your_own_vnet                 = true

# AZURE PRIVATE DNS ZONE
private_domain = [ "privatelink.mysql.database.azure.com" ]