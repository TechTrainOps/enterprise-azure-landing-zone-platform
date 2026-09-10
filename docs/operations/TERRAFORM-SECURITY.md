# Terraform Security Scanning

Terraform configuration is scanned during CI/CD using Checkov.

The security scan is executed through the shared Terraform pipeline template.

---

## Pipeline Flow

```text
Terraform Format
       |
       v
Terraform Init
       |
       v
Terraform Validate
       |
       v
Checkov Security Scan
       |
       v
Terraform Plan
```

---

## Scope

The scan evaluates Terraform configuration under the domain Terraform root.

Examples:

```text
environments/dev/compute/
environments/dev/networking/
environments/dev/security/
```

The same model applies to Test and Production.

---

## Handling Findings

Security findings should not be ignored without review.

For each finding:

1. Review the Checkov rule.
2. Determine whether the finding applies.
3. Fix the Terraform configuration when appropriate.
4. If the finding is not applicable, document the reason.
5. Only suppress a finding when there is a valid technical reason.

---

## Security Principle

The objective of the scan is to identify insecure Terraform configuration before infrastructure changes reach the main branch.

The security scan does not replace Azure Policy, Azure security controls, or runtime monitoring.