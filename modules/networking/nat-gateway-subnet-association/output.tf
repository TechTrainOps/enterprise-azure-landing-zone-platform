output "id" {
  description = "NAT Gateway subnet association ID"

  value = azurerm_subnet_nat_gateway_association.association.id
}