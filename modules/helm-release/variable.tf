# Nginx ingress controller

variable "name" {
  type = string
  description = "Ngnix ingress controller name"
}

variable "repository" {
  type = string
  description = "helm repo"
}

variable "chart" {
  type = string
  description = "helm chart"
}

variable "namespace" {
  type = string
  description = "AKS namespace"
}

variable "create_namespace" {
  type = bool
  description = "create new namespace for resources"
  default = true
}

variable "version" {
  type = string
  description = "Helm resources version"
  default = ""
}

variable "values" {
  type = list(string)
  description = "Helm value"
}