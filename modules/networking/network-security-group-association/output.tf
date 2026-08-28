output "id" {
  description = "The ID of the subnet and Network Security Group association"

  value = azurerm_subnet_network_security_group_association.association.id
}