locals { 
  a_records     = var.a_records
  cname_records = var.cname_records
}

#--------------------------------------------------------------------------------------------------------------------
# Deploying the azure private dns zone
#--------------------------------------------------------------------------------------------------------------------
resource "azurerm_private_dns_zone" "this" {
  name                = var.domain_name
  resource_group_name = var.resource_group_name

  tags = var.tags
}

#--------------------------------------------------------------------------------------------------------------------
# Private Only DNS A Records
#--------------------------------------------------------------------------------------------------------------------
resource "azurerm_private_dns_a_record" "a_records_private" {
  depends_on = [
    azurerm_private_dns_zone.this
  ]
  for_each = { for rs in local.a_records : rs.name => rs }

  resource_group_name = var.resource_group_name
  zone_name           = var.domain_name

  name    = each.value.name
  ttl     = each.value.ttl
  records = each.value.value
}

#--------------------------------------------------------------------------------------------------------------------
# Private ONLY DNS CNAME Records
#--------------------------------------------------------------------------------------------------------------------
resource "azurerm_private_dns_cname_record" "cname_records_private" {
  depends_on = [
    azurerm_private_dns_zone.this
  ]
  for_each = { for rs in local.cname_records : rs.name => rs }

  resource_group_name = var.resource_group_name
  zone_name           = var.domain_name

  name   = each.value.name
  ttl    = each.value.ttl
  record = each.value.value
}

#--------------------------------------------------------------------------------------------------------------------
# Private DNS Virtual Network Links
#--------------------------------------------------------------------------------------------------------------------
resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  name                  = join("",[lower(var.resource_group_name),"-link"])
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.this.name
  virtual_network_id    = var.vnet_id
}