resource_group_name = "rg-ealz-test-eastus2"
location            = "eastus2"

tags = {
  Environment = "test"
  Project     = "enterprise-azure-landing-zone-platform"
  ManagedBy   = "terraform"
  Owner       = "Shakir"
}


# Existing Networking resources

vnet_name   = "vnet-ealz-test-eastus2-001"
subnet_name = "snet-ealz-test-eastus2-001"


# Existing Identity resource

managed_identity_name = "id-ealz-test-eastus2-001"


# Availability Set

availability_set_name = "availset-ealz-test-eastus2-001"


# Linux VM

linux_vm_name = "vm-ealz-test-eastus2-001"

linux_vm_size = "Standard_D2als_v7"

linux_vm_admin_username = "linuxadmin"

linux_vm_admin_ssh_public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKMiTgSmASLiC8hP5uaEfVZsc5VBIYXhafbjgfYAcuwm ealz-test-linux-vm"


# Windows VM

windows_vm_name = "vm-windows-ealz-test-eastus2-001"

windows_vm_size = "Standard_D2als_v7"

windows_vm_admin_username = "azureadmin"

windows_vm_admin_password = "pass@1234"


# Managed Disk

managed_disk_name = "disk-ealz-test-eastus2-001"

managed_disk_size_gb = 64


# Linux VM extension

vm_extension_name = "ama-linux"


# Linux VMSS

vmss_name = "vmss-ealz-test-eastus2-001"

vmss_sku = "Standard_D2als_v7"

vmss_instances = 2