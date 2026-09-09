cd "$env:BUILD_SOURCESDIRECTORY\environments\dev\governance"

Write-Host "Current Terraform directory:"
Get-Location

terraform init -input=false

if ($LASTEXITCODE -ne 0) {
    throw "Terraform init failed."
}

terraform state list

terraform plan