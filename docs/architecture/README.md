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
├── pipelines/
└── scripts/
```

## Environment Architecture

Each environment follows the same seven-domain structure.

```text
                         Environment
                              |
        -------------------------------------------------
        |         |          |          |        |      |
        RG     Identity   Networking  Security Monitoring
                                                         
                              |                   |
                           Compute            Governance
```

Each domain is independently managed using its own Terraform root and state file.

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

### Security

Responsible for:

- Azure Key Vault
- Azure Storage Account
- Azure Container Registry
- Security-related RBAC assignments

Private Endpoints and Private DNS are owned by Networking.

Managed Identity and its RBAC assignments are owned by Identity.

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

Monitoring resources such as DCRs, DCR associations and alerts remain owned by Monitoring.

### Governance

Responsible for:

- Custom Azure Policy Definitions
- Azure Policy Assignments

Monitoring diagnostic policy assignments remain under Monitoring ownership.

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

Development uses seven independent state files:

```text
dev-resource-groups.tfstate
dev-identity.tfstate
dev-networking.tfstate
dev-security.tfstate
dev-monitoring.tfstate
dev-compute.tfstate
dev-governance.tfstate
```

Test and Production will follow the same naming convention.

## State Isolation

Each environment and domain must have its own state.

For example:

```text
dev-compute.tfstate
test-compute.tfstate
prod-compute.tfstate
```

An environment must never use another environment's Terraform state.

## Cross-Domain Ownership

Resources are managed by only one Terraform root.

Examples:

```text
Private Endpoint
    └── Networking

Managed Identity
    └── Identity

Key Vault
    └── Security

Diagnostic Settings
    └── Monitoring

Azure Policy Assignment
    └── Governance

Virtual Machine
    └── Compute
```

This prevents multiple Terraform states from attempting to manage the same Azure resource.