output "id" {
  description = "The ID of the subnet route table association"

  value = azurerm_subnet_route_table_association.association.id
}

output "subnet_id" {
  description = "The ID of the associated subnet"

  value = var.subnet_id
}

output "route_table_id" {
  description = "The ID of the associated route table"

  value = var.route_table_id
}