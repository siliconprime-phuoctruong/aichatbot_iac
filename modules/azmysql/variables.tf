variable "name" {
  default     = ""
  type        = string
  description = "Prefix of the resource name."
}
variable "db_name" {
  default     = []
  type        = list(string)
}

variable "location" {
  default     = "eastus"
  type        = string
  description = "Location of the resource."
}

variable "environment" {
  description = "Enviornment tag of the pg server"
  type        = string
  default     = ""
}

variable "resource_group_name" {
  description = "Specify the name of the resource group to be created"
  type        = string
}

variable "vnet_integration_enabled" {
  type = bool
}
variable "delegated_subnet_id" {
  type = string
}
variable "private_dns_zone_id" {
  type = string
}
variable "administrator_username" {
  description = "Administrator username for the MySQL server."
  type        = string
  default     = ""
}

variable "administrator_password" {
  description = "Administrator password for the MySQL server."
  type        = string
  default     = ""
}

variable "sku_name" {
  description = "SKU name for the MySQL server."
  type        = string
  default     = ""
}

variable "mysql_version" {
  description = "Version of MySQL server."
  type        = string
  default     = "8.0.21"
}

variable "auto_grow_enabled" {
  description = "Enable auto grow for storage."
  type        = bool
  default     = true
}

variable "iops" {
  description = "IOPS for storage."
  type        = string
  default     = "5000"
}

variable "storage_size_gb" {
  description = "Storage size in GB for the MySQL server."
  type        = string
  default     = "128"
}

variable "backup_retention_days" {
  description = "Number of days to retain backups."
  type        = string
  default     = "30"
}

variable "geo_redundant_backup_enabled" {
  description = "Enable geo-redundant backups."
  type        = bool
  default     = true
}

variable "zones" {
  description = "Availability zones for the MySQL server."
  type        = string
  default     = "2"
}

variable "db_collation" {
  description = "Collation for the MySQL database."
  type        = string
  default     = "utf8_unicode_ci"
}

variable "db_charset" {
  description = "Character set for the MySQL database."
  type        = string
  default     = "utf8"
}

variable "diagnostics_enabled" {
  description = "Enable diagnostics for logging and monitoring."
  type        = bool
  default     = false
}

variable "start_ip_address" {
  description = "Start IP address for the firewall rule."
  type        = string
  default     = ""
}

variable "end_ip_address" {
  description = "End IP address for the firewall rule."
  type        = string
  default     = ""
}

variable "tags" {
  description = "The tags to associate with your network and subnets."
  type        = map(string)

  default = {
    tag1 = ""
    tag2 = ""
  }
}

variable "maintenance_window" {
  description = "Maintenance window settings."
  type        = map(any)
  default = {
    day_of_week  = 3
    start_hour   = 3
    start_minute = 0
  }
}


variable "mysql_configurations" {
  type = map(string)
  default = {
    innodb_buffer_pool_size = "12884901888"
    max_allowed_packet      = "536870912"
    table_definition_cache  = "5000"
    table_open_cache        = "5000"
  }
}