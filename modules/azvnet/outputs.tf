output "subnet_ids" {
  value = {
    for k, subnet in azurerm_subnet.subnet_for_each : k => subnet.id
  }
}

output "vnet_ids" {
  value = azurerm_virtual_network.this.id
}

output "name" {
  value = azurerm_virtual_network.this.name
}