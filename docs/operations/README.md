# Operations

## Overview

This document describes the operational procedures and rules for managing the Terraform platform.

The platform uses independent Terraform roots and state files for each environment and infrastructure domain.

## Terraform Working Directory

Terraform commands must be executed from the appropriate environment and domain root.

Example:

```text
environments/dev/networking/
```

for Development Networking.

Do not run Terraform commands from the repository root unless specifically required.

## Standard Terraform Commands

### Initialize Terraform

```powershell
terraform init
```

### Validate Terraform

```powershell
terraform validate
```

### Check Terraform Formatting

```powershell
terraform fmt -check -recursive -diff
```

### Generate a Plan

```powershell
terraform plan
```

### Apply Changes

```powershell
terraform apply
```

For Test and Production, Terraform Apply should normally be performed through the Azure DevOps deployment pipeline.

## Terraform State

Terraform state is stored in Azure Storage.

```text
Resource Group:
rg-ealz-tfstate-eus2-001

Storage Account:
stealztfstate001

Container:
tfstate
```

Each environment and domain has its own state file.

## State Naming Convention

Development:

```text
dev-resource-groups.tfstate
dev-identity.tfstate
dev-networking.tfstate
dev-security.tfstate
dev-monitoring.tfstate
dev-compute.tfstate
dev-governance.tfstate
```

Test:

```text
test-resource-groups.tfstate
test-identity.tfstate
test-networking.tfstate
test-security.tfstate
test-monitoring.tfstate
test-compute.tfstate
test-governance.tfstate
```

Production:

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

Each environment must use its own Terraform state.

For example:

```text
Development Compute
    |
    └── dev-compute.tfstate

Test Compute
    |
    └── test-compute.tfstate

Production Compute
    |
    └── prod-compute.tfstate
```

A Production Terraform root must never use a Development or Test state.

## Resource Ownership

A resource must be managed by only one Terraform root.

The ownership model is:

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

A resource should not be declared in multiple Terraform roots.

## State Backup

Before performing state migration or manual state manipulation, create a backup.

```powershell
terraform state pull > state-backup.json
```

Retain the backup until the operation has been fully validated.

## State Inspection

List resources managed by the current Terraform state:

```powershell
terraform state list
```

Inspect a specific resource:

```powershell
terraform state show '<resource-address>'
```

Always confirm the correct Terraform working directory and backend before inspecting or modifying state.

## State Removal

The command:

```powershell
terraform state rm '<resource-address>'
```

removes a resource from Terraform state.

It does not delete the corresponding Azure resource.

State removal should only be performed when intentionally transferring ownership between Terraform states or retiring Terraform management.

A state backup should be created before performing the operation.

## Terraform Plan Verification

Always review the Terraform plan before applying changes.

For an environment where no changes are expected:

```text
Plan: 0 to add, 0 to change, 0 to destroy.
```

If an unexpected change appears, do not apply the plan until the cause is understood.

Pay particular attention to:

```text
Create
Update
Replace
Destroy
```

operations.

## Unexpected Resource Changes

If Terraform shows unexpected changes:

1. Do not apply the plan.
2. Confirm the Terraform working directory.
3. Confirm the backend state file.
4. Run `terraform state list`.
5. Inspect the affected resource with `terraform state show`.
6. Verify the resource ownership.
7. Compare Terraform configuration with the existing Azure resource.
8. Check whether another Terraform root manages the same resource.
9. Re-run the plan after correcting the issue.

## Resource Replacement

Resource replacement requires additional review.

If Terraform shows:

```text
-/+ resource
```

or indicates that a resource must be replaced, determine why the replacement is required before applying.

Do not assume that a replacement is safe for an existing production resource.

## State Migration

The Development environment was originally managed using a monolithic Terraform root.

Original structure:

```text
environments/dev/
```

Original state:

```text
dev.tfstate
```

The environment was migrated into seven independent Terraform roots:

```text
environments/dev/resource-groups/
environments/dev/identity/
environments/dev/networking/
environments/dev/security/
environments/dev/monitoring/
environments/dev/compute/
environments/dev/governance/
```

Existing Azure resources were imported into the new state files.

The migration did not recreate the existing Azure resources.

After successful validation, the migrated resources were removed from the old monolithic state.

The old monolithic Terraform configuration was then retired.

## Migration Validation

Each migrated root was validated using Terraform plan.

The expected result after migration was:

```text
Plan: 0 to add, 0 to change, 0 to destroy.
```

All seven Development roots were validated successfully.

## Troubleshooting State Issues

If a resource unexpectedly appears as a new resource:

```text
Plan: 1 to add
```

first check whether the resource exists in the current Terraform state.

```powershell
terraform state list
```

If the resource is missing from state, do not immediately apply.

Confirm whether:

- The resource already exists in Azure.
- The resource belongs to another Terraform root.
- The correct backend is being used.
- The resource needs to be imported.

## Importing Existing Resources

When an existing Azure resource needs to be brought under Terraform management:

1. Confirm the resource belongs to the current Terraform root.
2. Confirm the resource is not already managed by another Terraform state.
3. Configure the Terraform resource.
4. Initialize the backend.
5. Import the existing Azure resource.
6. Run `terraform plan`.
7. Confirm the plan does not attempt to recreate the resource.

Example:

```powershell
terraform import '<resource-address>' '<azure-resource-id>'
```

## Backend Verification

Before running state operations, verify that Terraform is using the expected backend.

Use:

```powershell
terraform init
```

and confirm the backend configuration corresponds to the intended environment and domain.

For example:

```text
Development Networking
    |
    └── dev-networking.tfstate
```

Do not perform state operations if the wrong backend has been initialized.

## Operational Safety Rules

### Rule 1: Verify the Environment

Always confirm whether you are working with:

```text
dev
test
prod
```

### Rule 2: Verify the Domain

Confirm the Terraform root:

```text
resource-groups
identity
networking
security
monitoring
compute
governance
```

### Rule 3: Verify the State

Confirm that the backend state belongs to the correct environment and domain.

### Rule 4: Review the Plan

Never apply an unexpected Terraform plan.

### Rule 5: Protect Existing Resources

Do not recreate existing Azure resources when moving Terraform ownership between states.

### Rule 6: Maintain Single Ownership

A resource must have one Terraform owner and one Terraform state.

## Production Operations

Production should follow the controlled deployment process:

```text
Pull Request
    |
    v
PR Validation
    |
    v
Terraform Plan
    |
    v
Merge to main
    |
    v
Terraform Plan
    |
    v
Production Approval
    |
    v
Terraform Apply
```

Direct manual changes to Production infrastructure should be avoided where the resource is managed by Terraform.

## Operational Principle

The core Terraform ownership rule is:

```text
One Azure Resource
        |
        v
One Terraform Root
        |
        v
One Terraform State
```

Following this model prevents state conflicts, accidental resource recreation, and unintended infrastructure changes.