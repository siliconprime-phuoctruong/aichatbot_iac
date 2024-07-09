output "admin_client_certificate" {
  value = module.aks.admin_client_certificate
  sensitive = true
}
output "admin_client_key" {
  value = module.aks.admin_client_key
  sensitive = true
}
output "admin_cluster_ca_certificate" {
  value = module.aks.admin_cluster_ca_certificate
  sensitive = true
}
output "admin_host" {
  value = module.aks.admin_host
  sensitive = true
}
output "admin_username" {
  value = module.aks.admin_username
  sensitive = true
}
output "admin_password" {
  value = module.aks.admin_password
  sensitive = true
}