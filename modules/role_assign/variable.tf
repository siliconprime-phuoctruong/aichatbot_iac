# Role assign
variable "aks_principal_id" {
  type = string
  description = "AKS Cluster principal ID"
}

variable "role" {
  type = string
  description = "role that need to be assigned"
  default = "Network Contributor"
}

variable "aks_scope" {
  type = string
  description = "Resources ID"
}