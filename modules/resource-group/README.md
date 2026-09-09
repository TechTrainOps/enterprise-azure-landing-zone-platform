# Resource Group Module Documentation

Generated documentation for the implemented resource group module in the repository.

Included modules: 1.

## Implemented modules

### `resource-group`

Creates an Azure Resource Group.

**Purpose**
- Provides the common resource-group boundary for the environment.
- Accepts the resource group name, Azure region, and tags.
- Exposes the resource group ID, name, location, and tags for dependent modules.

**Files**
- `main.tf`
- `variables.tf`
- `output.tf`

**Typical use**
Used as the foundational scope for the Azure landing-zone resources deployed into an environment.

END