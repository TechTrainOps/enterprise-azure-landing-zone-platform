# Enterprise Azure Landing Zone Platform

Terraform-based Azure Landing Zone platform designed to provide a consistent, modular, secure, and controlled way to deploy Azure infrastructure across multiple environments.

The platform uses reusable Terraform modules, independent Terraform state per domain, Azure DevOps pipelines for validation and controlled deployment, Terraform security scanning with Checkov, and scheduled drift detection.

---

## Architecture

The platform is divided into seven independent Terraform domains:

1. Resource Groups
2. Identity
3. Networking
4. Security
5. Monitoring
6. Compute
7. Governance

Each domain has its own Terraform root and independent Terraform state.

Example:

```text
Environment
    |
    +-- Resource Groups
    |
    +-- Identity
    |
    +-- Networking
    |
    +-- Security
    |
    +-- Monitoring
    |
    +-- Compute
    |
    +-- Governance
```

For detailed architecture information, see [Architecture Documentation](docs/architecture/README.md).

---

## Repository Structure

```text
enterprise-azure-landing-zone-platform/

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
│   │
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
│   ├── terraform-bootstrap.yml
│   └── terraform-drift-detection.yml
│
└── scripts/
```

---

## Environment Model

The platform supports multiple environments using the same seven-domain structure.

```text
Development
    |
    +-- Resource Groups
    +-- Identity
    +-- Networking
    +-- Security
    +-- Monitoring
    +-- Compute
    +-- Governance

Test
    |
    +-- Resource Groups
    +-- Identity
    +-- Networking
    +-- Security
    +-- Monitoring
    +-- Compute
    +-- Governance

Production
    |
    +-- Resource Groups
    +-- Identity
    +-- Networking
    +-- Security
    +-- Monitoring
    +-- Compute
    +-- Governance
```

Environment-specific configuration is maintained within each environment's Terraform roots.

---

## Terraform State

Terraform state is stored remotely in Azure Storage.

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

State isolation ensures that changes to one environment or domain do not directly modify the state of another environment or domain.

---

## Resource Ownership

Each Azure resource is managed by one Terraform domain.

Examples:

```text
Resource Group
    -> Resource Groups

Managed Identity
    -> Identity

Virtual Network
    -> Networking

Private Endpoint
    -> Networking

Private DNS Zone
    -> Networking

Key Vault
    -> Security

Storage Account
    -> Security

Container Registry
    -> Security

Diagnostic Settings
    -> Monitoring

Log Analytics Workspace
    -> Monitoring

Data Collection Rules
    -> Monitoring

Virtual Machine
    -> Compute

Virtual Machine Scale Set
    -> Compute

Azure Policy Assignment
    -> Governance
```

This prevents multiple Terraform roots from managing the same Azure resource.

### Domain Responsibilities

| Domain | Primary Responsibility |
|---|---|
| Resource Groups | Azure Resource Groups |
| Identity | Managed Identity and its RBAC assignments |
| Networking | VNet, subnets, NSGs, routes, NAT, Bastion, Private Endpoints and Private DNS |
| Security | Key Vault, Storage Account, ACR and security-related RBAC |
| Monitoring | Log Analytics, diagnostics, alerts, DCRs and monitoring RBAC |
| Compute | Virtual Machines, VMSS, disks and extensions |
| Governance | Azure Policy Definitions and Policy Assignments |

---

## Terraform Modules

Reusable Terraform modules are stored under:

```text
modules/
```

Environment roots consume these reusable modules.

For example:

```text
environments/dev/compute/
        |
        v
modules/compute/
```

The same reusable modules can be used by Test and Production.

Environment-specific configuration remains within the corresponding environment Terraform roots.

---

## Pipeline Model

Each environment has seven domain-specific Azure DevOps pipelines.

There are 21 domain pipelines in total:

```text
3 environments
×
7 domains
=
21 domain pipelines
```

All domain pipelines use the shared Terraform pipeline template:

```text
pipelines/templates/terraform-domain.yml
```

The Terraform bootstrap pipeline is responsible for the remote state infrastructure and is separate from the 21 environment/domain pipelines.

The drift detection pipeline is also separate from the deployment pipelines.

---

## Pipeline Organization

```text
pipelines/

├── templates/
│   └── terraform-domain.yml
│
├── dev/
│   ├── terraform-dev-resource-groups.yml
│   ├── terraform-dev-identity.yml
│   ├── terraform-dev-networking.yml
│   ├── terraform-dev-security.yml
│   ├── terraform-dev-monitoring.yml
│   ├── terraform-dev-compute.yml
│   └── terraform-dev-governance.yml
│
├── test/
│   ├── terraform-test-resource-groups.yml
│   ├── terraform-test-identity.yml
│   ├── terraform-test-networking.yml
│   ├── terraform-test-security.yml
│   ├── terraform-test-monitoring.yml
│   ├── terraform-test-compute.yml
│   └── terraform-test-governance.yml
│
├── prod/
│   ├── terraform-prod-resource-groups.yml
│   ├── terraform-prod-identity.yml
│   ├── terraform-prod-networking.yml
│   ├── terraform-prod-security.yml
│   ├── terraform-prod-monitoring.yml
│   ├── terraform-prod-compute.yml
│   └── terraform-prod-governance.yml
│
├── terraform-bootstrap.yml
└── terraform-drift-detection.yml
```

---

## Shared Pipeline Template

The common Terraform deployment logic is maintained in:

```text
pipelines/templates/terraform-domain.yml
```

The environment-specific pipeline files provide values such as:

- Environment
- Domain
- Terraform working directory
- Azure service connection
- Backend resource group
- Backend storage account
- Backend container
- Backend state key
- Azure DevOps deployment environment

This allows the same Terraform workflow to be reused across Development, Test and Production.

---

## Pull Request Validation

Pull requests targeting `main` run Terraform validation and planning.

The validation process includes:

```text
Pull Request
     |
     v
Terraform Format Check
     |
     v
Terraform Init
     |
     v
Terraform Validate
     |
     v
Terraform Security Scan
     |
     v
Terraform Plan
     |
     v
Publish Plan
```

The Terraform security scan uses Checkov to identify security and configuration issues in the Terraform code before infrastructure changes are deployed.

No Terraform Apply is performed during Pull Request validation.

The pipelines use path filters so that changes are validated by the relevant environment and domain pipeline.

For example:

```text
Change:
environments/dev/compute/**

Pipeline:
terraform-dev-compute.yml
```

Changes to unrelated environment or domain paths do not trigger pipelines whose path filters do not match those changes.

---

## Main Branch Deployment

Changes merged into `main` follow the controlled deployment flow:

```text
Merge to main
     |
     v
Terraform Init
     |
     v
Terraform Validate
     |
     v
Terraform Plan
     |
     v
Publish Plan
     |
     v
Azure DevOps Environment Approval
     |
     v
Terraform Apply
```

Terraform Apply only runs after the Plan stage succeeds and the required deployment environment approval is completed.

The Apply stage is restricted to the `main` branch.

---

## Terraform Security Scanning

Terraform security scanning is integrated into the shared pipeline template using Checkov.

```text
Terraform Format
       |
Terraform Init
       |
Terraform Validate
       |
Checkov Security Scan
       |
Terraform Plan
       |
Publish Plan
```

Because the security scan is implemented in the shared pipeline template, the same security validation is applied across the domain pipelines that consume the template.

Security findings should be reviewed before infrastructure changes are deployed.

---

## Drift Detection

The platform includes a dedicated Terraform drift detection pipeline:

```text
pipelines/terraform-drift-detection.yml
```

Drift detection is separate from the normal deployment pipelines.

Its purpose is to identify differences between the Terraform configuration/state and the infrastructure currently deployed in Azure.

The drift detection workflow performs Terraform planning and does not automatically apply changes.

```text
Scheduled Drift Detection
          |
          v
Terraform Init
          |
          v
Terraform Validate
          |
          v
Terraform Plan
          |
          v
Review Drift
```

Drift detection helps identify infrastructure changes that may have been introduced outside the normal Terraform deployment process.

Examples include changes made through:

- Azure Portal
- Azure CLI
- PowerShell
- Other automation systems

Any detected drift should be reviewed before corrective action is taken.

---

## Pipeline Isolation

Each environment/domain pipeline operates against its corresponding Terraform root and state.

### Development

```text
terraform-dev-compute.yml
        |
        v
environments/dev/compute/
        |
        v
dev-compute.tfstate
```

### Test

```text
terraform-test-compute.yml
        |
        v
environments/test/compute/
        |
        v
test-compute.tfstate
```

### Production

```text
terraform-prod-compute.yml
        |
        v
environments/prod/compute/
        |
        v
prod-compute.tfstate
```

This keeps environment and domain deployments isolated.

---

## Pipeline Count

The platform contains:

```text
3 environments
×
7 domains
=
21 domain pipelines
```

In addition to the 21 domain pipelines, the platform includes:

```text
1 Terraform bootstrap pipeline
1 Terraform drift detection pipeline
1 shared Terraform pipeline template
```

The bootstrap and drift detection pipelines are separate from the 21 domain deployment pipelines.

---

## Deployment Environments

Azure DevOps deployment environments are used to control the Apply stage.

The environment model is:

```text
Development
    |
    +-- Development deployment environment

Test
    |
    +-- Test deployment environment

Production
    |
    +-- Production deployment environment
```

Approvals and permissions can be configured independently for each environment.

Production should have stricter approval and access controls than Development and Test.

---

## Infrastructure Separation

The platform separates infrastructure responsibilities into distinct Terraform domains.

```text
Resource Groups
        |
        +-- Resource Group resources

Identity
        |
        +-- Managed Identity
        +-- Identity RBAC

Networking
        |
        +-- VNet
        +-- Subnets
        +-- NSGs
        +-- Routes
        +-- NAT
        +-- Bastion
        +-- Private Endpoints
        +-- Private DNS

Security
        |
        +-- Key Vault
        +-- Storage Account
        +-- Container Registry
        +-- Security RBAC

Monitoring
        |
        +-- Log Analytics
        +-- Diagnostics
        +-- Alerts
        +-- Data Collection Rules
        +-- Monitoring RBAC

Compute
        |
        +-- Virtual Machines
        +-- VMSS
        +-- Disks
        +-- Extensions

Governance
        |
        +-- Policy Definitions
        +-- Policy Assignments
```

---

## Infrastructure Safety

The platform uses separate Terraform state files and domain ownership to reduce the impact of changes.

Infrastructure changes should be made through pull requests and the corresponding Azure DevOps deployment pipeline.

Manual changes to Azure resources should be avoided because they can result in Terraform drift.

Before applying infrastructure changes, the Terraform plan should always be reviewed.

Existing resources must not be recreated unintentionally.

When restructuring Terraform configuration or moving resources between Terraform roots, state migration should be performed carefully so that existing Azure resources remain managed without recreation.

---

## Documentation

Additional documentation:

- [Architecture](docs/architecture/README.md)
- [Deployment](docs/deployment/README.md)
- [Operations](docs/operations/README.md)

The documentation covers:

```text
Architecture
    |
    +-- Terraform domains
    +-- Resource ownership
    +-- State architecture
    +-- Pipeline architecture

Deployment
    |
    +-- Pipeline execution
    +-- PR validation
    +-- Plan and Apply
    +-- Deployment approvals

Operations
    |
    +-- Terraform operations
    +-- State management
    +-- Imports
    +-- State migration
    +-- Troubleshooting
    +-- Operational procedures
```

---

## Terraform Version

Terraform:

```text
1.15.9
```

AzureRM provider:

```text
~> 5.0
```

---

## Azure Region

Development infrastructure currently uses:

```text
East US 2
```

Environment-specific regions should be defined through environment configuration.

---

## Project Goals

The platform is designed to provide:

- Reusable Terraform modules
- Independent domain ownership
- Independent Terraform state
- Environment separation
- Pull request validation
- Terraform security scanning
- Controlled deployments
- Azure governance
- Centralized monitoring
- Infrastructure security
- Drift detection
- Operational visibility