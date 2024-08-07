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

variable "aks_vnet_id" {
  type = string
  description = "AKS vnet ID"
}

# Nginx ingress controller
variable "nginx_ingress_name" {
  type = string
  description = "Ngnix ingress controller name"
}

variable "nginx_repo" {
  type = string
  description = "Nginx ingress controller helm repo"
  default = "https://kubernetes.github.io/ingress-nginx/"
}

variable "nginx_chart" {
  type = string
  description = "Nginx ingress controller helm chart"
  default = "ingress-nginx"
}

variable "nginx_namespace" {
  type = string
  description = "Nginx ingress controller namespace"
  default = "ingress"
}