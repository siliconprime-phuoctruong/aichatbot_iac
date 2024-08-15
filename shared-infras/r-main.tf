#--------------------------------------------------------------------------------------------------------------------
# RESOURCE GROUP
#--------------------------------------------------------------------------------------------------------------------
module "arg" {
  for_each            = toset(var.azrg_suffix)
  source              = "../modules/azrg"

  resource_group_name = upper(join("-", ["azrg", var.project, var.environment, each.key]))
  location            = var.location

  tags                = merge(local.default_tags, var.extra_tags)
}

#--------------------------------------------------------------------------------------------------------------------
# AZURE VIRTUAL NETWORK
#--------------------------------------------------------------------------------------------------------------------
 module "vnet" {
  source              = "../modules/azvnet"
  resource_group_name = module.arg[element(var.azrg_suffix, 1)].name
  location            = var.location

  # Configure virtual network
  vnet_name            = local.vnet_name
  address_space        = var.address_space
  bgp_community        = var.bgp_community
  dns_servers          = var.dns_servers
  ddos_protection_plan = var.ddos_protection_plan

  # Configure subnet
  use_for_each    = var.use_for_each
  subnet_prefixes = var.address_space
  subnet_names    = [local.aks_subnet, local.be_subnet, local.mgmt_subnet, local.appgw_subnet]

  subnet_service_endpoints = {
    (local.aks_subnet)   = var.subnet_service_endpoints
    (local.be_subnet)    = var.subnet_service_endpoints
    (local.mgmt_subnet)  = var.subnet_service_endpoints
    (local.appgw_subnet) = var.subnet_service_endpoints
  }

  tags       = merge(local.default_tags, var.extra_tags)
  depends_on = [module.arg]
}

#--------------------------------------------------------------------------------------------------------------------
# AZURE APPLICATION GATEWAY
#--------------------------------------------------------------------------------------------------------------------
#module "appgw_pip" {
#  source = "../modules/azpip"
#  count = var.use_brown_field_application_gateway && var.bring_your_own_vnet ? 1 : 0
#
#  resource_group_name = module.arg[element(var.azrg_suffix, 1)].name
#  location            = var.location
#
#  allocation_method   = var.appgw_allocation_method
#  name                = join("-", [var.project, var.environment, var.azgw_suffix, "pip", random_id.suffix.hex])
#  sku                 = var.appgw_sku
#}
#
#module "appgw" {
#  source = "../modules/azappgw"
#  count = var.use_brown_field_application_gateway && var.bring_your_own_vnet ? 1 : 0
#
#  resource_group_name = module.arg[element(var.azrg_suffix, 1)].name
#  location            = var.location
#
#  name = join("-", [var.project, var.environment, var.azgw_suffix, random_id.suffix.hex])
#
#  http_setting_name               = local.http_setting_name
#  frontend_ip_configuration_name  = local.frontend_ip_configuration_name
#  frontend_port_name              = local.frontend_port_name
#  listener_name                   = local.listener_name
#  request_routing_rule_name       = local.request_routing_rule_name
#  backend_address_pool_name       = local.backend_address_pool_name
#  public_ip_address_id            = module.appgw_pip[0].id
#  appgw_subnet_id                 = module.vnet.subnet_ids[local.appgw_subnet]
#
#  tags = merge(local.default_tags, var.extra_tags)
#  depends_on = [module.arg]
#
#}
#
#--------------------------------------------------------------------------------------------------------------------
# AZURE PRIVATE DNS ZONE
#--------------------------------------------------------------------------------------------------------------------
module "private_dns" {
  for_each = toset(var.private_domain)
  source = "../modules/azpridns"

  resource_group_name = module.arg[element(var.azrg_suffix, 1)].name
  domain_name         = each.key
  a_records           = var.a_records
  cname_records       = var.cname_records
  vnet_id             = module.vnet.vnet_ids

  tags       = merge(local.default_tags, var.extra_tags)
  depends_on = [ module.arg, module.vnet ]
}