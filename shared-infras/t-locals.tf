locals {
  default_tags = var.default_tags_enable ? {
    environment = var.environment
    project     = var.project
    owner       = var.owner
  } : {}
  ## Virtual network
  vnet_name    = upper(join("-", [var.project, var.environment, var.vnet_version, element(var.azrg_suffix, 1), random_id.suffix.hex]))
  aks_subnet   = upper(join("-", [var.project, var.environment, var.vnet_version, element(var.subnet_suffix, 0)]))
  be_subnet    = upper(join("-", [var.project, var.environment, var.vnet_version, element(var.subnet_suffix, 1)]))
  mgmt_subnet  = upper(join("-", [var.project, var.environment, var.vnet_version, element(var.subnet_suffix, 2)]))
  appgw_subnet = upper(join("-", [var.project, var.environment, var.vnet_version, element(var.subnet_suffix, 3)]))

  ## Application Gateway
  backend_address_pool_name      = try(join("-", [local.appgw_subnet, "beap"]), "")
  frontend_ip_configuration_name = try(join("-", [local.appgw_subnet, "feip"]), "")
  frontend_port_name             = try(join("-", [local.appgw_subnet, "feport"]), "")
  http_setting_name              = try(join("-", [local.appgw_subnet, "be-setting"]), "")
  listener_name                  = try(join("-", [local.appgw_subnet, "listener"]), "")
  request_routing_rule_name      = try(join("-", [local.appgw_subnet, "rule"]), "")
}