cd "$env:BUILD_SOURCESDIRECTORY\environments\dev\monitoring"

Write-Host "Current Terraform directory:"
Get-Location

terraform init -input=false

if ($LASTEXITCODE -ne 0) {
    throw "Terraform init failed."
}

terraform import 'module.linux_vm_data_collection_rule_association.azurerm_monitor_data_collection_rule_association.association' '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Compute/virtualMachines/vm-ealz-dev-eastus2-001/providers/Microsoft.Insights/dataCollectionRuleAssociations/dcr-assoc-linux-vm'

terraform import 'module.windows_vm_data_collection_rule_association.azurerm_monitor_data_collection_rule_association.association' '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Compute/virtualMachines/vm-windows-ealz-dev-eastus2-001/providers/Microsoft.Insights/dataCollectionRuleAssociations/dcr-assoc-windows-vm'

terraform import 'module.vmss_data_collection_rule_association.azurerm_monitor_data_collection_rule_association.association' '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Compute/virtualMachineScaleSets/vmss-ealz-dev-eastus2-001/providers/Microsoft.Insights/dataCollectionRuleAssociations/dcr-assoc-vmss'

terraform state list | Select-String "data_collection_rule_association"

terraform plan