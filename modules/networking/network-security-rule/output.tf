output "ids" {
  description = "Map of Network Security Rule IDs"

  value = {
    for key, rule in azurerm_network_security_rule.rule :
    key => rule.id
  }
}

output "names" {
  description = "Map of Network Security Rule names"

  value = {
    for key, rule in azurerm_network_security_rule.rule :
    key => rule.name
  }
}

output "priorities" {
  description = "Map of Network Security Rule priorities"

  value = {
    for key, rule in azurerm_network_security_rule.rule :
    key => rule.priority
  }
}