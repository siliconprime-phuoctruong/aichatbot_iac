variable "project" {
  description = "Project stack name."
  type        = string
}

variable "environment" {
  description = "Project environment."
  type        = string
}

variable "location" {
  description = "Azure location name"
  type        = string
}

variable "owner" {
  description = "Project onwer name."
  type        = string
}

variable "domain" {
  description = "Domain name"
  type        = string
}

variable "default_tags_enable" {
  description = "Option to enable or disable default tags."
  type        = bool
  default     = true
}

variable "extra_tags" {
  description = "Extra tags to add."
  type        = map(string)
  default     = {}
}

variable "azrg_suffix" {
  description = "Resource group suffix name"
  type        = list(string)
  default = ["app", "vnet", "aks"]
}

# Config Vnet
variable "subnet_suffix" {
  description = "Subnet suffix name"
  type        = list(string)
  default = [ "app", "vnet" ]
}
variable "vnet_version" {
  description = "Vnet version"
  default = "t1"
}
variable "address_space" {
  type        = list(string)
  default     = []
  description = "The address space that is used by the virtual network."
}

variable "bgp_community" {
  type        = string
  description = "(Optional) The BGP community attribute in format `<as-number>:<community-value>`."
}

variable "dns_servers" {
  type        = list(string)
  default     = []
  description = "The DNS servers to be used with vNet."
}

variable "ddos_protection_plan" {
  type = object({
    enable = bool
    id     = string
  })
  default     = null
  description = "The set of DDoS protection plan configuration"
}

variable "use_for_each" {
  type        = bool
  description = "Use `for_each` instead of `count` to create multiple resource instances."
  nullable    = false
}

variable "subnet_service_endpoints" {
  type        = list(string)
  default     = []
  description = "A list of subnet name to service endpoints to add to the subnet."
}

# Azure Application Gateway
variable "azgw_suffix" {
  type = string
}
variable "use_brown_field_application_gateway" {
  type = bool
}
variable "bring_your_own_vnet" {
  type = bool
}
variable "appgw_allocation_method" {
  type = string
}
variable "appgw_sku" {
  type = string
}

# Azure Private DNS zone
variable "private_domain" {
  type = list(string)
}
variable "a_records" {
  type = list(object({
    name  = string
    ttl   = number
    value = list(string)
  }))
  description = "List of A records."
  default     = []
}
variable "cname_records" {
  type = list(object({
    name  = string
    ttl   = number
    value = string
  }))
  description = "List of CNAME records."
  default     = []
}