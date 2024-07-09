output "azrg_name" {
  value = {
    for k , v in module.arg: k => v.name
  }
}
output "subnet_ids" {
  value = module.vnet.subnet_ids
}
output "appgw_id" {
  value = module.appgw[0].id
}
output "random_id" {
  value = random_id.suffix.hex
}
output "private_dns_zone_id" {
  value = {
    for k , v in module.private_dns: k => v.id
  }
}