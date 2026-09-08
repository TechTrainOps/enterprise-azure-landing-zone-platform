cd "$env:BUILD_SOURCESDIRECTORY\environments\dev\monitoring"

Write-Host "Current Terraform directory:"
Get-Location

terraform init -input=false

if ($LASTEXITCODE -ne 0) {
    throw "Terraform init failed."
}

terraform import 'module.compute_data_collection_rule.azurerm_monitor_data_collection_rule.compute' '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Insights/dataCollectionRules/dcr-ealz-dev-eastus2-compute-001'