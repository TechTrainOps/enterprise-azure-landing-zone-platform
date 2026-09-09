cd "$env:BUILD_SOURCESDIRECTORY\environments\dev\compute"

Write-Host "Current Terraform directory:"
Get-Location

terraform init -input=false

if ($LASTEXITCODE -ne 0) {
    throw "Terraform init failed."
}

terraform state pull > compute-state-backup-before-avset-reimport.tfstate

Get-Item .\compute-state-backup-before-avset-reimport.tfstate

terraform state rm 'module.availability_set.azurerm_availability_set.compute'

terraform state list | Select-String "availability_set"

terraform import 'module.availability_set.azurerm_availability_set.compute' '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Compute/availabilitySets/availset-ealz-dev-eastus2-001'

terraform state show 'module.availability_set.azurerm_availability_set.compute'

terraform plan