locals {
  azurerm_subnets = var.use_for_each ? [for s in azurerm_subnet.subnet_for_each : s] : []
  azurerm_subnets_name_id_map = {
    for index, subnet in local.azurerm_subnets :
    subnet.name => subnet.id
  }
  subnet_names_prefixes = zipmap(var.subnet_names, var.subnet_prefixes)
}

resource "azurerm_virtual_network" "this" {
  address_space       = var.address_space
  location            = var.location
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
  bgp_community       = var.bgp_community
  dns_servers         = var.dns_servers
  tags                = var.tags

  dynamic "ddos_protection_plan" {
    for_each = var.ddos_protection_plan != null ? [var.ddos_protection_plan] : []

    content {
      enable = ddos_protection_plan.value.enable
      id     = ddos_protection_plan.value.id
    }
  }
}

moved {
  from = azurerm_subnet.subnet
  to   = azurerm_subnet.subnet_for_each
}

resource "azurerm_subnet" "subnet_for_each" {
  for_each = var.use_for_each ? toset(var.subnet_names) : []

  address_prefixes                               = [local.subnet_names_prefixes[each.value]]
  name                                           = each.value
  resource_group_name                            = var.resource_group_name
  virtual_network_name                           = azurerm_virtual_network.this.name
  private_endpoint_network_policies_enabled      = lookup(var.subnet_enforce_private_link_endpoint_network_policies, each.value, false)
  private_link_service_network_policies_enabled  = lookup(var.subnet_enforce_private_link_service_network_policies, each.value, false)
  service_endpoints                              = lookup(var.subnet_service_endpoints, each.value, null)

  dynamic "delegation" {
    for_each = lookup(var.subnet_delegation, each.value, {})

    content {
      name = delegation.key

      service_delegation {
        name    = lookup(delegation.value, "service_name")
        actions = lookup(delegation.value, "service_actions", [])
      }
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "vnet" {
  for_each = var.nsg_ids

  network_security_group_id = each.value
  subnet_id                 = local.azurerm_subnets_name_id_map[each.key]
}

resource "azurerm_subnet_route_table_association" "vnet" {
  for_each = var.route_tables_ids

  route_table_id = each.value
  subnet_id      = local.azurerm_subnets_name_id_map[each.key]
}
