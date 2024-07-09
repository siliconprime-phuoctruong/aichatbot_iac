resource "azurerm_application_gateway" "this" {
  resource_group_name = var.resource_group_name
  location = var.location
  #checkov:skip=CKV_AZURE_120:We don't need the WAF for this simple example
  name = var.name

  backend_address_pool {
    name = var.backend_address_pool_name
  }
  backend_http_settings {
    cookie_based_affinity = "Disabled"
    name                  = var.http_setting_name
    port                  = 80
    protocol              = "Http"
    request_timeout       = 1
  }
  frontend_ip_configuration {
    name                 = var.frontend_ip_configuration_name
    public_ip_address_id = var.public_ip_address_id
  }
  frontend_port {
    name = var.frontend_port_name
    port = 80
  }
  gateway_ip_configuration {
    name      = "appGatewayIpConfig"
    subnet_id = var.appgw_subnet_id
  }
  http_listener {
    frontend_ip_configuration_name = var.frontend_ip_configuration_name
    frontend_port_name             = var.frontend_port_name
    name                           = var.listener_name
    protocol                       = "Http"
  }
  request_routing_rule {
    http_listener_name         = var.listener_name
    name                       = var.request_routing_rule_name
    rule_type                  = "Basic"
    backend_address_pool_name  = var.backend_address_pool_name
    backend_http_settings_name = var.http_setting_name
    priority                   = 1
  }
  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 1
  }

  lifecycle {
    ignore_changes = [
      tags,
      backend_address_pool,
      backend_http_settings,
      http_listener,
      probe,
      request_routing_rule,
      url_path_map,
    ]
  }

  tags = var.tags
}