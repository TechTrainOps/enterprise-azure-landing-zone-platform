cd "$env:BUILD_SOURCESDIRECTORY\environments\dev\compute"

Write-Host "Current Terraform directory:"
Get-Location

terraform init -input=false

if ($LASTEXITCODE -ne 0) {
    throw "Terraform init failed."
}

terraform import 'module.managed_disk.azurerm_virtual_machine_data_disk_attachment.linux_vm_data_disk' '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Compute/virtualMachines/vm-ealz-dev-eastus2-001/dataDisks/disk-ealz-dev-eastus2-001'

terraform state list