resource "azurerm_policy_definition" "policy" {
  name         = var.name
  policy_type  = "Custom"
  mode         = "All"
  display_name = var.display_name
  description  = var.description

  policy_rule = jsonencode({
    if = {
      anyOf = [
        {
          field  = "tags['Environment']"
          exists = "false"
        },
        {
          field  = "tags['ManagedBy']"
          exists = "false"
        },
        {
          field  = "tags['Owner']"
          exists = "false"
        },
        {
          field  = "tags['Project']"
          exists = "false"
        },
        {
          field  = "tags['ResourceType']"
          exists = "false"
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