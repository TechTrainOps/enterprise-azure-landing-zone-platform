# Go to the Terraform root
cd "$env:BUILD_SOURCESDIRECTORY\environments\dev\compute"

Write-Host "Current Terraform directory:"
Get-Location

Write-Host "=== Terraform Init ==="

terraform init -input=false

if ($LASTEXITCODE -ne 0) {
    throw "Terraform init failed."
}

Write-Host "Terraform init completed successfully."

terraform Plan

# Go to the Terraform root
cd "$env:BUILD_SOURCESDIRECTORY\environments\dev\governance"

Write-Host "Current Terraform directory:"
Get-Location

Write-Host "=== Terraform Init ==="

terraform init -input=false

if ($LASTEXITCODE -ne 0) {
    throw "Terraform init failed."
}

Write-Host "Terraform init completed successfully."

terraform Plan

# Go to the Terraform root
cd "$env:BUILD_SOURCESDIRECTORY\environments\dev\identity"

Write-Host "Current Terraform directory:"
Get-Location

Write-Host "=== Terraform Init ==="

terraform init -input=false

if ($LASTEXITCODE -ne 0) {
    throw "Terraform init failed."
}

Write-Host "Terraform init completed successfully."

terraform Plan

# Go to the Terraform root
cd "$env:BUILD_SOURCESDIRECTORY\environments\dev\monitoring"

Write-Host "Current Terraform directory:"
Get-Location

Write-Host "=== Terraform Init ==="

terraform init -input=false

if ($LASTEXITCODE -ne 0) {
    throw "Terraform init failed."
}

Write-Host "Terraform init completed successfully."

terraform Plan


# Go to the Terraform root
cd "$env:BUILD_SOURCESDIRECTORY\environments\dev\networking"

Write-Host "Current Terraform directory:"
Get-Location

Write-Host "=== Terraform Init ==="

terraform init -input=false

if ($LASTEXITCODE -ne 0) {
    throw "Terraform init failed."
}

Write-Host "Terraform init completed successfully."

terraform Plan

# Go to the Terraform root
cd "$env:BUILD_SOURCESDIRECTORY\environments\dev\resource-groups"

Write-Host "Current Terraform directory:"
Get-Location

Write-Host "=== Terraform Init ==="

terraform init -input=false

if ($LASTEXITCODE -ne 0) {
    throw "Terraform init failed."
}

Write-Host "Terraform init completed successfully."

terraform Plan


# Go to the Terraform root
cd "$env:BUILD_SOURCESDIRECTORY\environments\dev\security"

Write-Host "Current Terraform directory:"
Get-Location

Write-Host "=== Terraform Init ==="

terraform init -input=false

if ($LASTEXITCODE -ne 0) {
    throw "Terraform init failed."
}

Write-Host "Terraform init completed successfully."

terraform Plan