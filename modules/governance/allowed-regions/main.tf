resource "azurerm_policy_definition" "policy" {
  name         = var.name
  policy_type  = "Custom"
  mode         = "All"
  display_name = var.display_name
  description  = var.description

  policy_rule = jsonencode({
    if = {
      allOf = [
        {
          field = "location"
          notIn = var.allowed_locations
        },
        {
          field     = "location"
          notEquals = "global"
        }
      ]
    }

    then = {
      effect = "audit"
    }
  })

  metadata = jsonencode({
    category = "Governance"
  })
}