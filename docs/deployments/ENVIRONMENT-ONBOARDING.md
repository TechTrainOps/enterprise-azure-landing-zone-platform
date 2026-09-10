# Environment Onboarding Guide

This document describes how to add a new environment to the Enterprise Azure Landing Zone Platform.

The platform uses the same seven-domain structure for every environment.

---

## Supported Domains

Every environment contains:

```text
resource-groups
identity
networking
security
monitoring
compute
governance
```

Example:

```text
environments/<environment>/

├── resource-groups/
├── identity/
├── networking/
├── security/
├── monitoring/
├── compute/
└── governance/
```

---

# 1. Create the Environment Directory

For a new environment, create:

```text
environments/<environment>/
```

For example:

```text
environments/test/
```

Create the seven domain directories:

```text
environments/test/

├── resource-groups/
├── identity/
├── networking/
├── security/
├── monitoring/
├── compute/
└── governance/
```

---

# 2. Copy the Domain Root Structure

Use the existing Dev environment as the baseline.

For example:

```text
environments/dev/compute/
```

can be used as the starting structure for:

```text
environments/test/compute/
```

The same approach applies to all seven domains.

Do not copy Terraform state files.

Do not copy the `.terraform` directory.

Do not copy `tfplan` files.

---

# 3. Update Environment Configuration

Each environment must have its own environment-specific values.

Typical values include:

```text
resource group name
location
resource names
network address ranges
subnet ranges
environment tags
policy configuration
```

For example:

```hcl
environment = "test"
location    = "eastus2"
```

The exact variables depend on the domain.

---

# 4. Configure Terraform Backend

Each environment/domain must use its own state key.

Example for Test:

```text
test-resource-groups.tfstate
test-identity.tfstate
test-networking.tfstate
test-security.tfstate
test-monitoring.tfstate
test-compute.tfstate
test-governance.tfstate
```

Example backend:

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-ealz-tfstate-eus2-001"
    storage_account_name = "stealztfstate001"
    container_name       = "tfstate"
    key                  = "test-compute.tfstate"
    use_azuread_auth     = true
  }
}
```

Never use the Dev state key for Test or Production.

---

# 5. Bootstrap State

Before deploying the environment, ensure the Terraform state storage infrastructure exists.

The bootstrap configuration is responsible for creating the Terraform state storage.

Verify:

```text
Resource Group:
rg-ealz-tfstate-eus2-001

Storage Account:
stealztfstate001

Container:
tfstate
```

---

# 6. Initialize Each Domain

Run Terraform from each domain root.

Example:

```powershell
cd environments/test/compute

terraform init
```

Then:

```powershell
terraform validate
```

Then:

```powershell
terraform plan
```

Repeat for all seven domains.

---

# 7. Validate Resource Ownership

Before deployment, confirm that every resource belongs to only one Terraform root.

Examples:

```text
Networking
    -> VNet
    -> Subnets
    -> NSGs
    -> Route Tables
    -> NAT Gateway
    -> Private Endpoints
    -> Private DNS

Identity
    -> Managed Identity
    -> Identity role assignments

Security
    -> Key Vault
    -> Storage Account
    -> Container Registry

Monitoring
    -> Log Analytics
    -> Diagnostic Settings
    -> Alerts
    -> Data Collection Rules

Compute
    -> VMs
    -> VMSS
    -> Disks
    -> VM Extensions

Governance
    -> Policy Definitions
    -> Policy Assignments
```

A resource must not be managed by multiple roots.

---

# 8. Create Azure DevOps Pipelines

Create seven pipelines for the environment.

Example for Test:

```text
terraform-test-resource-groups
terraform-test-identity
terraform-test-networking
terraform-test-security
terraform-test-monitoring
terraform-test-compute
terraform-test-governance
```

Pipeline files should be stored under:

```text
pipelines/test/
```

---

# 9. Configure Pipeline Paths

Each domain pipeline should trigger only when relevant files change.

Example:

```yaml
paths:
  include:
    - environments/test/compute/**
    - modules/compute/**
    - pipelines/test/terraform-test-compute.yml
    - pipelines/templates/**
```

This prevents unrelated domain changes from triggering every pipeline.

---

# 10. Configure Service Connection

The environment pipeline must use the appropriate Azure DevOps service connection.

Example:

```yaml
serviceConnection: 'sc-ealz-test'
```

Production should use the appropriate production service connection.

Do not use a development service connection for Production.

---

# 11. Pull Request Validation

PR validation should run when changes are submitted to `main`.

Expected flow:

```text
Pull Request
     |
     v
Format Check
     |
     v
Terraform Init
     |
     v
Terraform Validate
     |
     v
Security Scan
     |
     v
Terraform Plan
```

No Terraform Apply occurs during PR validation.

---

# 12. Main Branch Deployment

After the PR is merged into `main`:

```text
main
 |
 v
Terraform Plan
 |
 v
Environment Approval
 |
 v
Terraform Apply
```

Apply should only run after successful Plan and required approval.

---

# 13. Environment Verification

After deployment verify:

```text
Terraform plan
    -> No unexpected changes

Azure resources
    -> Created/updated as expected

Terraform state
    -> Correct backend state file

Monitoring
    -> Alerts and diagnostic settings present

Governance
    -> Policy assignments present

Networking
    -> Connectivity working

Identity
    -> Required role assignments present
```

---

# 14. Environment Checklist

Before considering the environment complete:

- [ ] Seven domain directories created
- [ ] Environment-specific configuration updated
- [ ] Seven backend state keys configured
- [ ] Terraform initialization successful
- [ ] Terraform validation successful
- [ ] Terraform plan reviewed
- [ ] Resource ownership verified
- [ ] Azure DevOps service connection configured
- [ ] Seven pipelines created
- [ ] PR validation tested
- [ ] Main branch deployment tested
- [ ] Environment approval configured
- [ ] Monitoring verified
- [ ] Governance verified
- [ ] Documentation updated