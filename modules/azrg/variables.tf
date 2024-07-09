variable "location" {
  description = "Azure location name"
  type = string
}

variable "tags" {
  description = "Extra tags to add."
  type        = map(string)
  default     = {}
}

variable "resource_group_name" {
  description = "Azure Resource Group name"
  type = string
}