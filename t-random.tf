resource "random_id" "id" {
  byte_length = 2
}
resource "random_password" "mysql" {
  length = 14
  lower  = true
  special = false
}