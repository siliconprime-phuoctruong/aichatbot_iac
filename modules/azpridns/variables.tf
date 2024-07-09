variable "resource_group_name" {
  type        = string
  description = "Name of the resource group to be imported."
  nullable    = false
}

variable "domain_name" {
    type = string
    description = "Name of Domain you want to use"
}

variable "a_records" {
    type = list(object({
        name = string
        ttl = number
        value = list(string)
    }))
    description = "List of A records."
}
variable "cname_records" {
    type = list(object({
        name = string
        ttl = number
        value = string
    }))
    description = "List of CNAME records."
}

variable "tags" {
  description = "Extra tags to add."
  type        = map(string)
  default     = {}
}

variable "vnet_id" {
  description = "Vnet ids"
  type = string
  
}