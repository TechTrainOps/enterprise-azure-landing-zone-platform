output "route_ids" {
  description = "IDs of the routes"

  value = {
    for key, route in azurerm_route.route :
    key => route.id
  }
}

output "route_names" {
  description = "Names of the routes"

  value = {
    for key, route in azurerm_route.route :
    key => route.name
  }
}