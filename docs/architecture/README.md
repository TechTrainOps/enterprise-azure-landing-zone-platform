# Architecture

## Overview

The Enterprise Azure Landing Zone Platform is implemented using Terraform with reusable modules and environment-specific Terraform roots.

The infrastructure is divided into seven independent domains:

1. Resource Groups
2. Identity
3. Networking
4. Security
5. Monitoring
6. Compute
7. Governance

Each domain has its own Terraform root and independent Terraform state.

The platform supports multiple environments:

- Development
- Test
- Production

Each environment follows the same seven-domain structure.

## Repository Structure

```text
enterprise-azure-landing-zone-platform/
│
├── bootstrap/
│
├── docs/
│   ├── architecture/
│   │   └── README.md
│   ├── deployment/
│   │   └── README.md
│   └── operations/
│       └── README.md
│
├── environments/
│   ├── dev/
│   │   ├── resource-groups/
│   │   ├── identity/
│   │   ├── networking/
│   │   ├── security/
│   │   ├── monitoring/
│   │   ├── compute/
│   │   └── governance/
│   │
│   ├── test/
│   │   ├── resource-groups/
│   │   ├── identity/
│   │   ├── networking/
│   │   ├── security/
│   │   ├── monitoring/
│   │   ├── compute/
│   │   └── governance/
│   │
│   └── prod/
│       ├── resource-groups/
│       ├── identity/
│       ├── networking/
│       ├── security/
│       ├── monitoring/
│       ├── compute/
│       └── governance/
│
├── modules/
│   ├── compute/
│   ├── governance/
│   ├── identity/
│   ├── monitoring/
│   ├── networking/
│   ├── resource-group/
│   └── security/
│
├── pipelines/
│   ├── templates/
│   │   └── terraform-domain.yml
│   │
│   ├── dev/
│   │   ├── terraform-dev-resource-groups.yml
│   │   ├── terraform-dev-identity.yml
│   │   ├── terraform-dev-networking.yml
│   │   ├── terraform-dev-security.yml
│   │   ├── terraform-dev-monitoring.yml
│   │   ├── terraform-dev-compute.yml
│   │   └── terraform-dev-governance.yml
│   │
│   ├── test/
│   │   ├── terraform-test-resource-groups.yml
│   │   ├── terraform-test-identity.yml
│   │   ├── terraform-test-networking.yml
│   │   ├── terraform-test-security.yml
│   │   ├── terraform-test-monitoring.yml
│   │   ├── terraform-test-compute.yml
│   │   └── terraform-test-governance.yml
│   │
│   ├── prod/
│   │   ├── terraform-prod-resource-groups.yml
│   │   ├── terraform-prod-identity.yml
│   │   ├── terraform-prod-networking.yml
│   │   ├── terraform-prod-security.yml
│   │   ├── terraform-prod-monitoring.yml
│   │   ├── terraform-prod-compute.yml
│   │   └── terraform-prod-governance.yml
│   │
│   └── terraform-bootstrap.yml
│
└── scripts/
```

## Environment Architecture

Each environment contains seven independent Terraform roots.

```text
                         Environment
                              |
        -------------------------------------------------
        |         |          |          |        |      |
   Resource   Identity   Networking  Security Monitoring
    Groups
        |
        +-------------------+-------------------+
                            |                   |
                         Compute            Governance
```

The seven domains are logically independent and maintain separate Terraform state.

## Domain Ownership

### Resource Groups

Responsible for:

- Azure Resource Groups

### Identity

Responsible for:

- User-assigned Managed Identity
- Managed Identity RBAC assignments
- Key Vault access for the Managed Identity
- Storage Account access for the Managed Identity
- Azure Container Registry access for the Managed Identity

Managed Identity and its role assignments are owned only by Identity.

### Networking

Responsible for:

- Virtual Network
- Workload Subnet
- Bastion Subnet
- Network Security Group
- NSG Rules
- Route Table
- NAT Gateway
- NAT Public IP
- Bastion
- Bastion Public IP
- Private Endpoints
- Private DNS Zones
- Private DNS Zone Virtual Network Links
- Private Endpoint DNS Zone Groups

Networking owns Private Endpoints and Private DNS resources.

### Security

Responsible for:

- Azure Key Vault
- Azure Storage Account
- Azure Container Registry
- Security-related RBAC assignments

Private Endpoints and Private DNS are not managed by Security.

They are owned by Networking.

Managed Identity and its RBAC assignments are not managed by Security.

They are owned by Identity.

### Monitoring

Responsible for:

- Log Analytics Workspace
- Diagnostic Settings
- Diagnostic Policy Assignments
- Monitoring RBAC
- Action Groups
- Activity Log Alerts
- Metric Alerts
- Scheduled Query Alerts
- Data Collection Rules
- Data Collection Rule Associations

Diagnostic policy assignments and their required monitoring RBAC remain owned by Monitoring.

### Compute

Responsible for:

- Availability Set
- Linux Virtual Machine
- Windows Virtual Machine
- Linux Virtual Machine Scale Set
- Network Interfaces
- Managed Disk
- VM Data Disk Attachment
- VM Extensions
- VMSS Extensions

Networking resources such as VNets, subnets and NSGs remain owned by Networking.

Monitoring resources such as Data Collection Rules, associations and alerts remain owned by Monitoring.

### Governance

Responsible for:

- Custom Azure Policy Definitions
- Azure Policy Assignments

Monitoring diagnostic policy assignments remain under Monitoring ownership.

## Cross-Domain Resource Ownership

A resource must be managed by only one Terraform root.

Examples:

```text
Resource Group
    └── Resource Groups

Managed Identity
    └── Identity

Private Endpoint
    └── Networking

Private DNS Zone
    └── Networking

Key Vault
    └── Security

Storage Account
    └── Security

Azure Container Registry
    └── Security

Diagnostic Settings
    └── Monitoring

Data Collection Rules
    └── Monitoring

Virtual Machine
    └── Compute

Virtual Machine Scale Set
    └── Compute

Azure Policy Assignment
    └── Governance
```

This prevents multiple Terraform states from attempting to manage the same Azure resource.

## Terraform State Architecture

Terraform state is stored in Azure Storage.

```text
Resource Group:
rg-ealz-tfstate-eus2-001

Storage Account:
stealztfstate001

Container:
tfstate
```

Each environment and domain uses an independent state file.

### Development

```text
dev-resource-groups.tfstate
dev-identity.tfstate
dev-networking.tfstate
dev-security.tfstate
dev-monitoring.tfstate
dev-compute.tfstate
dev-governance.tfstate
```

### Test

```text
test-resource-groups.tfstate
test-identity.tfstate
test-networking.tfstate
test-security.tfstate
test-monitoring.tfstate
test-compute.tfstate
test-governance.tfstate
```

### Production

```text
prod-resource-groups.tfstate
prod-identity.tfstate
prod-networking.tfstate
prod-security.tfstate
prod-monitoring.tfstate
prod-compute.tfstate
prod-governance.tfstate
```

## State Isolation

Each environment and domain must use its own Terraform state.

For example:

```text
dev-compute.tfstate
test-compute.tfstate
prod-compute.tfstate
```

An environment must never use another environment's Terraform state.

Similarly, one domain must not use another domain's state.

## Pipeline Architecture

Azure DevOps pipelines are separated by environment and domain.

The common Terraform pipeline logic is maintained in:

```text
pipelines/templates/terraform-domain.yml
```

Environment-specific pipeline files provide configuration to the shared template.

The configuration includes:

- Environment name
- Domain name
- Terraform working directory
- Service connection
- Backend resource group
- Backend storage account
- Backend container
- Backend state key
- Azure DevOps deployment environment

This avoids duplicating the same Terraform pipeline logic across all environments and domains.

## Pipeline Organization

```text
pipelines/
│
├── templates/
│   └── terraform-domain.yml
│
├── dev/
│   └── 7 domain pipelines
│
├── test/
│   └── 7 domain pipelines
│
├── prod/
│   └── 7 domain pipelines
│
└── terraform-bootstrap.yml
```

The shared template contains the common Terraform workflow.

The environment-specific pipeline files provide only the values that differ between environments and domains.