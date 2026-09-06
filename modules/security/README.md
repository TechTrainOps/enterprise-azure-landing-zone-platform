# Security Module Documentation

Generated documentation for the implemented security modules in the repository.

Included modules: 4.

## Implemented modules

### `container-registry`

Creates an Azure Container Registry.

**Purpose**
- Provides a reusable Azure Container Registry configuration.
- Supports registry SKU and security/network configuration.
- Exposes the registry resource ID, name, login server, and other resource details.

### `key-vault`

Creates an Azure Key Vault.

**Purpose**
- Provides centralized secret and key management.
- Supports RBAC authorization, network access controls, soft-delete retention, purge protection, and related Key Vault settings.
- Exposes the Key Vault resource details for dependent resources and role assignments.

### `key-vault-role-assignment`

Creates an Azure RBAC role assignment for a principal at a specified scope.

**Purpose**
- Provides reusable role-assignment logic for Key Vault and other Azure resources.
- Accepts the target scope, role definition, and principal ID.

### `storage-account`

Creates an Azure Storage Account.

**Purpose**
- Provides a reusable storage account configuration.
- Supports account kind, performance/tier, replication, access tier, HTTPS/TLS settings, public network access, and shared-key configuration.
- Supports network rules and landing-zone tagging.

**Files**
Each security module contains:
- `main.tf`
- `variables.tf`
- `output.tf`

**Typical use**
Used to provide protected platform services such as Key Vault, private Storage, and private Azure Container Registry resources.
