output "route_ids" {
  description = "Map of created route IDs"

  value = {
    for key, route in azurerm_route.route :
    key => route.id
  }
}

output "route_names" {
  description = "Map of created route names"

  value = {
    for key, route in azurerm_route.route :
    key => route.name
  }
}