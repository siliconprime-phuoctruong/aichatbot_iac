variable "f_name" {
  type = string
  description = "Azure identity federated ID"
}

variable "resource_group_name" {
  type = string
  description = "AKS resource group name"
}

variable "f_audience" {
  type = list(string)
  description = "Azure identity federated audience"
}

variable "f_issuer" {
  type = string
  description = "Azure identity federated issuer"
}

variable "parent_id" {
  type = string
  description = "Azure identity federated parent ID"
}

variable "subject" {
  type = string
  description = "Azure identity federated subject"
}