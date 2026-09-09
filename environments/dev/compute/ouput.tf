output "availability_set_id" {
  description = "Availability Set resource ID"
  value       = module.availability_set.id
}

output "linux_vm_id" {
  description = "Linux VM resource ID"
  value       = module.linux_virtual_machine.id
}

output "linux_vm_name" {
  description = "Linux VM name"
  value       = module.linux_virtual_machine.name
}

output "linux_vm_private_ip_address" {
  description = "Linux VM private IP address"
  value       = module.linux_virtual_machine.private_ip_address
}

output "linux_vm_network_interface_id" {
  description = "Linux VM network interface resource ID"
  value       = module.linux_virtual_machine.network_interface_id
}

output "windows_vm_id" {
  description = "Windows VM resource ID"
  value       = module.windows_virtual_machine.id
}

output "windows_vm_name" {
  description = "Windows VM name"
  value       = module.windows_virtual_machine.name
}

output "windows_vm_network_interface_id" {
  description = "Windows VM network interface resource ID"
  value       = module.windows_virtual_machine.network_interface_id
}

output "managed_disk_id" {
  description = "Managed disk resource ID"
  value       = module.managed_disk.id
}

output "managed_disk_name" {
  description = "Managed disk name"
  value       = module.managed_disk.name
}

output "linux_vm_extension_id" {
  description = "Linux VM Azure Monitor Agent extension resource ID"
  value       = module.linux_vm_extension.id
}

output "linux_vmss_id" {
  description = "Linux VMSS resource ID"
  value       = module.linux_virtual_machine_scale_set.id
}

output "windows_vm_extension_id" {
  description = "Windows VM Azure Monitor Agent extension resource ID"
  value       = module.windows_vm_extension.id
}

output "vmss_extension_id" {
  description = "VMSS Azure Monitor Agent extension resource ID"
  value       = module.vmss_extension.id
}