cd "$env:BUILD_SOURCESDIRECTORY\environments\dev\compute"

Write-Host "Current Terraform directory:"
Get-Location

terraform init -input=false

if ($LASTEXITCODE -ne 0) {
    throw "Terraform init failed."
}

terraform state show 'module.availability_set.azurerm_availability_set.compute'

terraform state show 'module.availability_set.azurerm_availability_set.compute' | Select-String "id|resource_group_name"