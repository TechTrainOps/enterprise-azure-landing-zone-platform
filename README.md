# Enterprise Azure Landing Zone Platform

Terraform-based Azure Landing Zone platform designed to provide a consistent, modular, and controlled way to deploy Azure infrastructure across multiple environments.

The platform uses reusable Terraform modules, independent Terraform state per domain, and Azure DevOps pipelines for validation and controlled deployment.

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
│   ├── dev/
│   ├── test/
│   └── prod/
│
└── scripts/
```

---

## Environment Model

The platform supports multiple environments using the same domain structure.

```text
Dev
 ├── Resource Groups
 ├── Identity
 ├── Networking
 ├── Security
 ├── Monitoring
 ├── Compute
 └── Governance

Test
 ├── Resource Groups
 ├── Identity
 ├── Networking
 ├── Security
 ├── Monitoring
 ├── Compute
 └── Governance

Prod
 ├── Resource Groups
 ├── Identity
 ├── Networking
 ├── Security
 ├── Monitoring
 ├── Compute
 └── Governance
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

The same pattern is used for Test and Production.

Example:

```text
test-compute.tfstate
prod-compute.tfstate
```

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

Virtual Machine
    -> Compute

Virtual Machine Scale Set
    -> Compute

Azure Policy Assignment
    -> Governance
```

This prevents multiple Terraform roots from managing the same resource.

---

## Terraform Modules

Reusable Terraform modules are stored under:

```text
modules/
```

Environment roots consume these modules.

For example:

```text
environments/dev/compute/
        |
        v
modules/compute/
```

The same reusable modules can be used by Test and Production.

---

## Pipeline Model

Each domain has its own Azure DevOps pipeline.

Example:

```text
pipelines/
├── dev/
│   ├── terraform-dev-compute.yml
│   ├── terraform-dev-governance.yml
│   ├── terraform-dev-identity.yml
│   ├── terraform-dev-monitoring.yml
│   ├── terraform-dev-networking.yml
│   ├── terraform-dev-resource-groups.yml
│   └── terraform-dev-security.yml
│
├── test/
│   └── ...
│
└── prod/
    └── ...
```

Pipelines use a shared Terraform template where applicable.

---

## Pull Request Validation

Pull requests targeting `main` run Terraform validation.

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
```

The Terraform plan is generated without applying infrastructure changes.

---

## Main Branch Deployment

Changes merged into `main` follow:

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
Azure DevOps Environment Approval
     |
     v
Terraform Apply
```

Terraform Apply only runs after the Plan stage succeeds and the deployment environment approval is completed.

---

## Infrastructure Safety

The platform uses separate Terraform state files and domain ownership to reduce the impact of changes.

Changes should be made through pull requests.

Manual changes to Azure resources should be avoided because they can result in Terraform drift.

---

## Documentation

Additional documentation:

- [Architecture](docs/architecture/README.md)
- [Deployment](docs/deployment/README.md)
- [Operations](docs/operations/README.md)

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
- Controlled production deployments
- Azure governance
- Centralized monitoring
- Infrastructure security
- Operational visibility