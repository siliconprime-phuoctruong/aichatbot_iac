locals {
  roles_map = { for role in var.roles : "${role.ppal_id}.${role.role}" => role }
}