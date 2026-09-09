cd "$env:BUILD_SOURCESDIRECTORY\environments\dev"

Write-Host "Current Terraform directory:"
Get-Location

terraform init -input=false

if ($LASTEXITCODE -ne 0) {
    throw "Terraform init failed."
}

terraform state rm 'module.availability_set.azurerm_availability_set.compute'

terraform state rm 'module.linux_virtual_machine.azurerm_linux_virtual_machine.linux_vm'

terraform state rm 'module.linux_virtual_machine.azurerm_network_interface.linux_vm'

terraform state rm 'module.linux_virtual_machine_scale_set.azurerm_linux_virtual_machine_scale_set.linux_vmss'

terraform state rm 'module.linux_vm_extension.azurerm_virtual_machine_extension.azure_monitor_agent'

terraform state rm 'module.managed_disk.azurerm_managed_disk.data_disk'

terraform state rm 'module.managed_disk.azurerm_virtual_machine_data_disk_attachment.linux_vm_data_disk'

terraform state rm 'module.windows_virtual_machine.azurerm_windows_virtual_machine.windows_vm'

terraform state rm 'module.windows_virtual_machine.azurerm_network_interface.windows_vm'

terraform state rm 'module.windows_vm_extension.azurerm_virtual_machine_extension.azure_monitor_agent'

terraform state rm 'module.vmss_extension.azurerm_virtual_machine_scale_set_extension.azure_monitor_agent'

terraform state list | Select-String "availability_set|linux_virtual_machine|windows_virtual_machine|managed_disk|vm_extension|virtual_machine_scale_set"


cd "$env:BUILD_SOURCESDIRECTORY\environments\dev\compute"

Write-Host "Current Terraform directory:"
Get-Location

terraform init -input=false

if ($LASTEXITCODE -ne 0) {
    throw "Terraform init failed."
}

terraform state list

terraform import 'module.availability_set.azurerm_availability_set.compute' '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/RG-EALZ-DEV-EASTUS2/providers/Microsoft.Compute/availabilitySets/availset-ealz-dev-eastus2-001'

terraform import 'module.linux_virtual_machine.azurerm_linux_virtual_machine.linux_vm' '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Compute/virtualMachines/vm-ealz-dev-eastus2-001'

terraform import 'module.linux_virtual_machine.azurerm_network_interface.linux_vm' '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Network/networkInterfaces/vm-ealz-dev-eastus2-001-nic'

terraform import 'module.linux_virtual_machine_scale_set.azurerm_linux_virtual_machine_scale_set.linux_vmss' '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Compute/virtualMachineScaleSets/vmss-ealz-dev-eastus2-001'

terraform import 'module.linux_vm_extension.azurerm_virtual_machine_extension.azure_monitor_agent' '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Compute/virtualMachines/vm-ealz-dev-eastus2-001/extensions/ama-linux'

terraform import 'module.managed_disk.azurerm_managed_disk.data_disk' '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Compute/disks/disk-ealz-dev-eastus2-001'

terraform import 'module.windows_virtual_machine.azurerm_windows_virtual_machine.windows_vm' '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Compute/virtualMachines/vm-windows-ealz-dev-eastus2-001'

terraform import 'module.windows_virtual_machine.azurerm_network_interface.windows_vm' '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Network/networkInterfaces/vm-windows-ealz-dev-eastus2-001-nic'

terraform import 'module.windows_vm_extension.azurerm_virtual_machine_extension.azure_monitor_agent' '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Compute/virtualMachines/vm-windows-ealz-dev-eastus2-001/extensions/ama-windows'

terraform import 'module.vmss_extension.azurerm_virtual_machine_scale_set_extension.azure_monitor_agent' '/subscriptions/2d1634f0-7a97-4b55-b237-f5b12e52c45c/resourceGroups/rg-ealz-dev-eastus2/providers/Microsoft.Compute/virtualMachineScaleSets/vmss-ealz-dev-eastus2-001/extensions/ama-linux'