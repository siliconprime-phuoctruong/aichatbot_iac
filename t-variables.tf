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

variable "app_services" {
  description = "The list of application services"
  type = list(string)
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
variable "aks_version" {
  description = "Kubernestes version"
  type = string
}
variable "aks_upgrade" {
  description = "Kubernetes automatic channel upgrade"
  type = string
}
variable "aks_agent_zones" {
  description = "Agent availability zones"
  type = list(string)
}
variable "aks_agent_count" {
  description = "Number of agents"
  type = number
}
variable "aks_max_count" {
 description = "Maximum number of agent"
 type = number 
}
variable "aks_min_count" {
  description = "Minimum number of agent"
  type = number
}
variable "aks_max_pod" {
  description = "Maximum number of pod in an agent"
  type = number
}
variable "aks_nodepool_count" {
  description = "Number of node pool"
  type = number
}
variable "aks_node_size" {
  description = "VM size will use for node pool"
  type = string
}
variable "aks_node_count" {
  description = "Number of node in a pool"
  type = number
}
variable "aks_agent_type" {
  description = "Type for master node"
  type = string
}
variable "aks_auto_scaling" {
  description = "Option to enable or disable for master node"
  type = bool
}
variable "aks_azure_policy_enabled" {
  description = "Option to enable or disable for Azure policy"
  type = bool
}
variable "aks_enable_host_encryption" {
  description = "Option to enable or disable for disk encryption at rest"
  type = bool
}
variable "aks_local_account_disabled" {
  description = "Option to enable or disable for Kubernetes local account"
  type = bool
}
variable "aks_log_analytics_workspace_enabled" {
  description = "Option to enable or disable for Logs analytics workspace"
  type = bool
}
variable "aks_dns_ip" {
  description = "Kubernetes DNS server ip"
  type = string
}
variable "aks_cidr" {
  description = "Kubernetes network range"
  type = string
}
variable "aks_network_plugin" {
  type = string
}
variable "aks_network_policy" {
  type = string
}
variable "aks_disk_volume" {
  type = number
}
variable "aks_private_cluster_enabled" {
  type = bool
}
variable "aks_rbac_aad" {
  type = bool
}
variable "aks_rbac_aad_managed" {
  type = bool
}
variable "aks_role_based_access_control_enabled" {
  type = bool
}
variable "aks_sku_tier" {
  type = string
}
variable "bring_your_own_vnet" {
  type    = bool
  default = true
}
variable "create_role_assignments_for_application_gateway" {
  type    = bool
  default = true
}

variable "use_brown_field_application_gateway" {
  type    = bool
  default = false
}

variable "acr_sku" {
  type        = string
  default     = "Basic"
  description = "The SKU name of the container registry."

  validation {
    condition     = contains(["Basic", "Standard ", "Premium"], var.acr_sku)
    error_message = "ERROR: Invalid SKU Tier must be one of Basic, Standard or Premium."
  }
}

variable "admin_enabled" {
  description = "Specifies whether the admin user is enabled."
  type        = bool
  default     = false
}

variable "encryption_enabled" {
  description = "Specifies whether the ACR encription is enabled."
  type = bool
}

variable "quarantine_policy_enabled" {
  description = "Specifies whether the ACR quarantine policy is enabled."
  type = bool
}
variable "db_name" {
  description = "The list of databases will be within MySQL server"
  type = list(string)
}
variable "mysql_version" {
  description = "Verion of Flexible MySQL server"
  type = string
}
variable "mysql_availability_zones" {
  description = "Number of zone that Flexiable mysql server will be located"
  type = number
}
variable "mysql_storage_size" {
  type = string
}
variable "mysql_sku" {
  type = string
}
variable "mysql_vnet_integration_enabled" {
  type = bool
}
variable "mysql_backup_retention_days" {
  type = string
}
variable "mysql_iops" {
  type = string
}
variable "mysql_auto_grow_enabled" {
  type = bool
}
variable "mysql_geo_redundant_enabled" {
  type = bool
}
variable "db_collation" {
  type = string
}
variable "db_charset" {
  type = string
}
variable "mysql_diagnostics_enabled" {
  type = bool
}
variable "mysql_start_ip" {
  type = string
}
variable "mysql_end_ip" {
  type = string
}