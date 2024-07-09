variable "name" {
  type        = string
  description = "The name of the Application Gateway."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the Application Gateway."
}

variable "location" {
  type        = string
  description = "The location/region where the Application Gateway is created."
}

variable "backend_address_pool_name" {
  type = string
}
variable "http_setting_name" {
  type = string
}
variable "frontend_port_name" {
  type = string
}
variable "listener_name" {
  type = string
}
variable "request_routing_rule_name" {
  type = string
}
variable "appgw_subnet_id" {
  type = string
}

variable "zones" {
  description = "A collection of availability zones to spread the Application Gateway over. This option is only supported for v2 SKUs"
  type        = list(number)
  default     = [1, 2, 3]
}

variable "frontend_ip_configuration_name" {
  type = string
  description = "App Gateway frontend IP name"
}

variable "public_ip_address_id" {
  type = string
  description = "App Gateway Public IP ID"
}

variable "tags" {
  description = "Extra tags to add."
  type        = map(string)
  default     = {}
}
