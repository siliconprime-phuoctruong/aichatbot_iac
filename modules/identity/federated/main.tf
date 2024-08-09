resource "azurerm_federated_identity_credential" "this" {
  name                = var.f_name
  resource_group_name = var.resource_group_name
  audience            = var.f_audience
  issuer              = var.f_issuer
  parent_id           = var.parent_id
  subject             = var.subject
}