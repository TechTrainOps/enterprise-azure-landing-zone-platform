# Deployment

## Overview

The platform uses Azure DevOps pipelines to validate and deploy Terraform infrastructure.

Each environment contains seven independent Terraform domains:

1. Resource Groups
2. Identity
3. Networking
4. Security
5. Monitoring
6. Compute
7. Governance

Each domain has its own Terraform root and Terraform state.

The Azure DevOps pipelines use a shared Terraform template to avoid duplicating the same pipeline logic across environments and domains.

## Pipeline Structure

```text
pipelines/
│
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
└── terraform-bootstrap.yml
```

## Shared Terraform Pipeline Template

The common Terraform pipeline logic is stored in:

```text
pipelines/templates/terraform-domain.yml
```

The shared template contains the common stages used by the domain pipelines.

### Pull Request Validation

```text
PR Validation
     |
     +-- Terraform Install
     +-- Terraform Format Check
     +-- Terraform Init
     +-- Terraform Validate
     +-- Terraform Plan
     +-- Publish Plan
```

### Main Branch Deployment

```text
Plan
 |
 +-- Terraform Install
 +-- Terraform Format Check
 +-- Terraform Init
 +-- Terraform Validate
 +-- Terraform Plan
 +-- Publish Plan
 |
 v
Apply
 |
 +-- Download Plan
 +-- Terraform Init
 +-- Terraform Apply
```

## Environment Pipeline Files

Each environment contains seven domain-specific pipeline files.

### Development

```text
terraform-dev-resource-groups.yml
terraform-dev-identity.yml
terraform-dev-networking.yml
terraform-dev-security.yml
terraform-dev-monitoring.yml
terraform-dev-compute.yml
terraform-dev-governance.yml
```

### Test

```text
terraform-test-resource-groups.yml
terraform-test-identity.yml
terraform-test-networking.yml
terraform-test-security.yml
terraform-test-monitoring.yml
terraform-test-compute.yml
terraform-test-governance.yml
```

### Production

```text
terraform-prod-resource-groups.yml
terraform-prod-identity.yml
terraform-prod-networking.yml
terraform-prod-security.yml
terraform-prod-monitoring.yml
terraform-prod-compute.yml
terraform-prod-governance.yml
```

## Environment Pipeline Configuration

Environment-specific pipeline files reference the shared Terraform template.

For example:

```text
pipelines/dev/terraform-dev-compute.yml
```

references:

```text
pipelines/templates/terraform-domain.yml
```

The environment/domain pipeline provides:

```text
environmentName
domainName
terraformWorkingDirectory
serviceConnection
backendResourceGroup
backendStorageAccount
backendContainer
backendKey
deploymentEnvironment
```

## Pull Request Validation

When a Pull Request targets the `main` branch, the relevant domain pipeline performs validation and planning.

The flow is:

```text
Pull Request
     |
     v
Checkout
     |
     v
Terraform Install
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
Terraform Plan
     |
     v
Publish Plan
```

No Terraform Apply is performed during Pull Request validation.

## Path Filters

Each pipeline uses path filters so that only relevant changes trigger the pipeline.

For example, the Development Compute pipeline monitors:

```text
environments/dev/compute/**
modules/compute/**
pipelines/dev/terraform-dev-compute.yml
pipelines/templates/**
```

The shared template is included in the path filter because changes to the shared Terraform pipeline logic can affect all domain pipelines.

Each environment/domain pipeline follows the same pattern with its corresponding environment and domain paths.

## Terraform Format Check

The pipeline checks Terraform formatting using:

```powershell
terraform fmt -check -recursive -diff
```

The format check is performed from the repository root.

## Terraform Initialization

Each Terraform root uses its own backend configuration.

Example:

```text
Development Compute

Working Directory:
environments/dev/compute/

Backend Key:
dev-compute.tfstate
```

Terraform is initialized using:

```text
terraform init
```

The backend uses Azure Storage with Microsoft Entra ID authentication.

## Terraform Validation

After initialization, the pipeline validates the Terraform configuration:

```text
terraform validate
```

Validation must succeed before the Terraform plan is generated.

## Terraform Plan

The pipeline generates a Terraform plan using:

```text
terraform plan -out=tfplan -input=false
```

The plan is stored as:

```text
tfplan
```

For Pull Request validation, a readable version is also generated:

```text
tfplan.txt
```

The plan files are published as Azure DevOps pipeline artifacts.

## Main Branch Deployment

After a Pull Request is merged into `main`, the relevant pipeline runs the deployment stages.

The flow is:

```text
Merge to main
     |
     v
Terraform Plan
     |
     v
Publish Terraform Plan
     |
     v
Environment Approval
     |
     v
Terraform Apply
```

## Plan and Apply Separation

The Plan stage creates the Terraform plan:

```text
tfplan
```

The plan is published as a pipeline artifact.

The Apply stage downloads the same artifact.

```text
Plan Stage
    |
    └── tfplan
          |
          v
    Pipeline Artifact
          |
          v
Apply Stage
    |
    └── terraform apply tfplan
```

This ensures that the Apply stage uses the plan generated by the Plan stage.

## Apply Conditions

The Apply stage runs only when:

1. The Plan stage succeeds.
2. The pipeline is running from the `main` branch.

The condition is:

```yaml
condition: and(
  succeeded('Plan'),
  eq(variables['Build.SourceBranch'], 'refs/heads/main')
)
```

This prevents Terraform Apply from running during Pull Request validation.

## Azure DevOps Environments

Each deployment environment has its own Azure DevOps environment.

Development:

```text
dev
```

Test:

```text
test
```

Production:

```text
prod
```

The Azure DevOps environment provides the deployment approval control before Terraform Apply.

## Backend Configuration

Each domain uses a separate Terraform state.

Example for Compute:

```text
Development:
dev-compute.tfstate

Test:
test-compute.tfstate

Production:
prod-compute.tfstate
```

The backend storage is:

```text
Resource Group:
rg-ealz-tfstate-eus2-001

Storage Account:
stealztfstate001

Container:
tfstate
```

## Pipeline Naming Convention

Pipeline files follow this naming convention:

```text
terraform-<environment>-<domain>.yml
```

Examples:

```text
terraform-dev-compute.yml
terraform-test-compute.yml
terraform-prod-compute.yml
```

## Deployment Model

The complete deployment flow is:

```text
                    Pull Request
                         |
                         v
                  PR Validation
                         |
                  Terraform Plan
                         |
                         v
                       Merge
                         |
                         v
                       main
                         |
                         v
                  Terraform Plan
                         |
                         v
                  Publish Plan
                         |
                         v
                Environment Approval
                         |
                         v
                  Terraform Apply
```

## Independent Domain Deployment

Each domain is deployed independently.

For example:

```text
Networking Change
       |
       v
terraform-dev-networking.yml
       |
       v
environments/dev/networking/
       |
       v
dev-networking.tfstate
```

A Networking deployment does not automatically modify:

```text
dev-compute.tfstate
dev-security.tfstate
dev-monitoring.tfstate
dev-governance.tfstate
```

Each domain maintains its own Terraform ownership.

## Pipeline Template Benefits

The shared template provides a single location for common Terraform pipeline logic.

The template handles:

- Terraform installation
- Terraform formatting
- Terraform initialization
- Terraform validation
- Terraform plan
- Plan artifact creation
- Plan artifact download
- Terraform apply

Environment/domain pipeline files contain configuration specific to the environment and domain.

If common pipeline behavior changes, the shared template can be updated instead of modifying all domain pipelines individually.

## Pipeline Count

The deployment model contains:

```text
3 environments
×
7 domains
=
21 domain pipelines
```

All 21 domain pipelines use the same shared Terraform pipeline template.

The Terraform bootstrap pipeline is separate from the 21 environment/domain pipelines.

## Deployment Principles

### Pull Requests

Pull Requests perform validation and planning only.

They must not modify Azure infrastructure.

### Main Branch

Merging to `main` triggers the deployment pipeline.

The pipeline generates a Terraform plan before applying changes.

### Approval

Terraform Apply requires the configured Azure DevOps environment approval.

### Independent Domains

Each domain is deployed independently using its own Terraform root and state.

### Shared Pipeline Logic

Common pipeline logic must be maintained in:

```text
pipelines/templates/terraform-domain.yml
```

Environment-specific configuration belongs in the corresponding environment pipeline file.