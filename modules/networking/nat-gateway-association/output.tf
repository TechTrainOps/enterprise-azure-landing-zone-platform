output "id" {
  description = "NAT Gateway and Public IP association ID"

  value = azurerm_nat_gateway_public_ip_association.association.id
}