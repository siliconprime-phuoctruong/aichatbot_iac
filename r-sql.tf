module "mysql" {
  source = "./modules/azmysql"

  name                         = local.mysql_server
  resource_group_name          = local.aks_azrg_name
  administrator_username       = local.admin_username
  administrator_password       = random_password.mysql.result
  mysql_version                = var.mysql_version
  zones                        = var.mysql_availability_zones
  storage_size_gb              = var.mysql_storage_size
  sku_name                     = var.mysql_sku
  vnet_integration_enabled     = var.mysql_vnet_integration_enabled
  delegated_subnet_id          = local.be_subnet_id
  private_dns_zone_id          = local.mysql_dns_id
  backup_retention_days        = var.mysql_backup_retention_days
  iops                         = var.mysql_iops
  auto_grow_enabled            = var.mysql_auto_grow_enabled
  geo_redundant_backup_enabled = var.mysql_geo_redundant_enabled
  db_name                      = var.db_name
  db_collation                 = var.db_collation
  db_charset                   = var.db_charset
  diagnostics_enabled          = var.mysql_diagnostics_enabled
  start_ip_address             = var.mysql_start_ip
  end_ip_address               = var.mysql_end_ip
  maintenance_window = {
    day_of_week  = 3
    start_hour   = 3
    start_minute = 0
  }
  tags = merge(local.default_tags, var.extra_tags)
}

module "store_mysql_password" {
  source    = "./modules/aks/secrets"

  id        = data.azurerm_key_vault.devops.id
  name      = local.mysql_server
  value     = random_password.mysql.result
}