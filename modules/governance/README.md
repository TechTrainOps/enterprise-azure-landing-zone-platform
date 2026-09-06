# Governance Module Documentation

Generated documentation for the implemented governance modules in the repository.

Included modules: 3.

## Implemented modules

### `allowed-regions`

Provides the configuration for an allowed Azure regions policy definition.

**Purpose**
- Defines a policy that restricts resource deployment to approved Azure regions.
- Supports reusable policy configuration and outputs the resulting policy definition information.

### `policy`

Creates a reusable Azure Policy Definition.

**Purpose**
- Defines custom Azure Policy rules and parameters.
- Supports policy metadata and lifecycle configuration.
- Exposes the policy definition resource details for assignments.

### `policy-assignment`

Assigns an Azure Policy Definition to a target scope.

**Purpose**
- Connects a policy definition to a subscription, resource group, or other supported Azure scope.
- Supports assignment parameters, identity configuration where applicable, enforcement settings, and metadata.

**Files**
Each governance module contains:
- `main.tf`
- `variables.tf`
- `output.tf`

**Typical use**
Used to implement landing-zone governance controls such as allowed locations and other policy-based guardrails.
