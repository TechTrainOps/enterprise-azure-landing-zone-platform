# Routes

Creates individual Azure routes in an existing Route Table.

## Purpose

Provides a separate reusable route resource layer when route definitions need to be managed independently from Route Table creation.

## Resources

- `azurerm_route`

## Inputs

| Name | Type | Description | Default |
|---|---|---|---|
| `routes` | `map(object)` | Map of routes to create | `{}` |

Each route contains the route name, resource group name, route table name, address prefix, next-hop type, and optional next-hop IP address.

## Outputs

| Name | Description |
|---|---|
| `route_ids` | Map of created route IDs |
| `route_names` | Map of created route names |
