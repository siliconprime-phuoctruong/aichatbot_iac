# Role assign
variable "aks_principal_id" {
  type = string
  description = "AKS Cluster principal ID"
}

variable "role" {
  type = string
  description = "AKS virtual network role"
  default = "Network Contributor"
}

variable "aks_scope" {
  type = string
  description = "AKS vnet ID"
}