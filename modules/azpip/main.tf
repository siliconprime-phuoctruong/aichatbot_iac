resource "azurerm_public_ip" "pip" {

  allocation_method   = var.allocation_method
  location            = var.location
  name                = var.name
  resource_group_name = var.resource_group_name
  sku                 = var.sku
}