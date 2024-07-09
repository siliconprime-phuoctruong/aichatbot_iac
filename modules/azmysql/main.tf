# Manages a MySQL Flexible Server.
resource "azurerm_mysql_flexible_server" "mysql" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  delegated_subnet_id = var.vnet_integration_enabled ? var.delegated_subnet_id : null
  private_dns_zone_id = var.vnet_integration_enabled ? var.private_dns_zone_id : null

  administrator_login    = var.administrator_username
  administrator_password = var.administrator_password

  sku_name = var.sku_name
  version  = var.mysql_version

  dynamic "maintenance_window" {
    for_each = var.maintenance_window != null ? toset([var.maintenance_window]) : toset([])

    content {
      day_of_week  = lookup(maintenance_window.value, "day_of_week", 0)
      start_hour   = lookup(maintenance_window.value, "start_hour", 0)
      start_minute = lookup(maintenance_window.value, "start_minute", 0)
    }
  }

  storage {
    auto_grow_enabled = var.auto_grow_enabled
    iops              = var.iops
    size_gb           = var.storage_size_gb
  }

  backup_retention_days        = var.backup_retention_days
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled
  zone                         = var.zones

  tags = var.tags

  lifecycle {
    ignore_changes = [
      tags,
      zone
    ]
  }
}

# Manages a MySQL Database within a MySQL Flexible Server
resource "azurerm_mysql_flexible_database" "mysql" {
  for_each            = toset(var.db_name)
  server_name         = azurerm_mysql_flexible_server.mysql.name
  resource_group_name = var.resource_group_name

  name          = each.key
  collation     = var.db_collation
  charset       = var.db_charset
  depends_on    = [azurerm_mysql_flexible_server.mysql]
}

# Manages a Firewall Rule for a MySQL Flexible Server.
resource "azurerm_mysql_flexible_server_firewall_rule" "mysql" {
  server_name         = azurerm_mysql_flexible_server.mysql.name
  resource_group_name = var.resource_group_name
  name                = format("%s-%s", var.name, "rules")
  start_ip_address    = var.start_ip_address
  end_ip_address      = var.end_ip_address
  depends_on          = [azurerm_mysql_flexible_server.mysql]
}

# Sets a MySQL Flexible Server Configuration value on a MySQL Flexible Server.
resource "azurerm_mysql_flexible_server_configuration" "mysql" {
  for_each            = var.mysql_configurations
  name                = each.key
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_flexible_server.mysql.name
  value               = each.value
  depends_on          = [azurerm_mysql_flexible_server.mysql]
}

data "azurerm_monitor_diagnostic_categories" "mysql_server" {
  count       = var.diagnostics_enabled == true ? 1 : 0
  resource_id = azurerm_mysql_flexible_server.mysql.id
  depends_on  = [azurerm_mysql_flexible_server.mysql]
}

resource "azurerm_log_analytics_workspace" "example" {
  count               = var.diagnostics_enabled ? 1 : 0
  name                = format("%s-%s", var.name, "workspace")
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  depends_on          = [azurerm_mysql_flexible_server.mysql]
}

resource "azurerm_monitor_diagnostic_setting" "mysql_server" {
  count = var.diagnostics_enabled == true ? 1 : 0

  name                       = format("%s-%s", var.name, "mysql")
  target_resource_id         = azurerm_mysql_flexible_server.mysql.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.example[0].id

  dynamic "log" {
    for_each = data.azurerm_monitor_diagnostic_categories.mysql_server[0].log_category_types
    content {
      category = log.value
      enabled  = true
      retention_policy {
        enabled = true
        days    = 90
      }
    }
  }
  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.mysql_server[0].metrics
    content {
      category = metric.value
      enabled  = true
      retention_policy {
        enabled = true
        days    = 90
      }
    }
  }
}