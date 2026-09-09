# Identity Module Documentation

Generated documentation for the implemented identity modules in the repository.

Included modules: 1.

## Implemented modules

### `user-assigned-identity`

Creates a reusable Azure User Assigned Managed Identity.

**Purpose**
- Provides a managed identity that can be assigned to Azure resources.
- Exposes the identity resource ID, client ID, principal ID, and name for downstream role assignments and resource configuration.

**Files**
- `main.tf`
- `variables.tf`
- `output.tf`

**Typical use**
Used by compute resources and Azure service integrations that require Azure AD / Microsoft Entra authentication without storing credentials.

END