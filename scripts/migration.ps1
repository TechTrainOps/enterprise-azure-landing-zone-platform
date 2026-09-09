cd "$env:BUILD_SOURCESDIRECTORY\environments\dev\governance"

Write-Host "Current Terraform directory:"
Get-Location

terraform init -input=false

if ($LASTEXITCODE -ne 0) {
    throw "Terraform init failed."
}

# ============================================================
# Verification
# ============================================================

Write-Host "=== Terraform State ==="

terraform state list

if ($LASTEXITCODE -ne 0) {
    throw "terraform state list failed."
}

Write-Host "=== Terraform Plan ==="

terraform plan -input=false

if ($LASTEXITCODE -ne 0) {
    throw "Terraform plan failed."
}