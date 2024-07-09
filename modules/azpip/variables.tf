variable "allocation_method" {
  type = string
}

variable "name" {
  type        = string
  description = "The name of the Public IP"
}

variable "resource_group_name" {
  type        = string
}

variable "location" {
  type        = string
}

variable "sku" {
  type = string
}