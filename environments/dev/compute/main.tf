data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

data "azurerm_subnet" "workload" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = data.azurerm_resource_group.rg.name
}

data "azurerm_user_assigned_identity" "managed_identity" {
  name                = var.managed_identity_name
  resource_group_name = data.azurerm_resource_group.rg.name
}


# ============================================================
# AVAILABILITY SET
# ============================================================

module "availability_set" {
  source = "../../../modules/compute/availability-set"

  name                = var.availability_set_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location

  tags = merge(
    var.tags,
    {
      ResourceType = "availability-set"
    }
  )
}


# ============================================================
# LINUX VIRTUAL MACHINE
# ============================================================

module "linux_virtual_machine" {
  source = "../../../modules/compute/linux-virtual-machine"

  name                = var.linux_vm_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location

  subnet_id = data.azurerm_subnet.workload.id

  vm_size        = var.linux_vm_size
  admin_username = var.linux_vm_admin_username

  admin_ssh_public_key = var.linux_vm_admin_ssh_public_key

  availability_set_id = module.availability_set.id

  user_assigned_identity_ids = [
    data.azurerm_user_assigned_identity.managed_identity.id
  ]

  tags = merge(
    var.tags,
    {
      ResourceType = "virtual-machine"
    }
  )
}


# ============================================================
# WINDOWS VIRTUAL MACHINE
# ============================================================

module "windows_virtual_machine" {
  source = "../../../modules/compute/windows-virtual-machine"

  name                = var.windows_vm_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location

  subnet_id = data.azurerm_subnet.workload.id

  size = var.windows_vm_size

  admin_username = var.windows_vm_admin_username
  admin_password = var.windows_vm_admin_password

  user_assigned_identity_ids = [
    data.azurerm_user_assigned_identity.managed_identity.id
  ]

  tags = merge(
    var.tags,
    {
      ResourceType = "windows-virtual-machine"
    }
  )
}


# ============================================================
# MANAGED DATA DISK
# ============================================================

module "managed_disk" {
  source = "../../../modules/compute/managed-disk"

  name                = var.managed_disk_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location

  disk_size_gb = var.managed_disk_size_gb

  virtual_machine_id = module.linux_virtual_machine.id

  tags = merge(
    var.tags,
    {
      ResourceType = "managed-disk"
    }
  )
}


# ============================================================
# LINUX VM AZURE MONITOR AGENT
# ============================================================

module "linux_vm_extension" {
  source = "../../../modules/compute/virtual-machine-extension"

  name               = var.vm_extension_name
  virtual_machine_id = module.linux_virtual_machine.id

  publisher            = "Microsoft.Azure.Monitor"
  type                 = "AzureMonitorLinuxAgent"
  type_handler_version = "1.0"

  tags = merge(
    var.tags,
    {
      ResourceType = "vm-extension"
    }
  )
}


# ============================================================
# LINUX VM SCALE SET
# ============================================================

module "linux_virtual_machine_scale_set" {
  source = "../../../modules/compute/virtual-machine-scale-set"

  name                = var.vmss_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location

  subnet_id = data.azurerm_subnet.workload.id

  sku       = var.vmss_sku
  instances = var.vmss_instances

  admin_username       = var.linux_vm_admin_username
  admin_ssh_public_key = var.linux_vm_admin_ssh_public_key

  user_assigned_identity_ids = [
    data.azurerm_user_assigned_identity.managed_identity.id
  ]

  tags = merge(
    var.tags,
    {
      ResourceType = "linux-vmss"
    }
  )
}


# ============================================================
# WINDOWS VM AZURE MONITOR AGENT
# ============================================================

module "windows_vm_extension" {
  source = "../../../modules/compute/windows-vm-extension"

  name               = "ama-windows"
  virtual_machine_id = module.windows_virtual_machine.id

  tags = merge(
    var.tags,
    {
      ResourceType = "virtual-machine-extension"
    }
  )
}


# ============================================================
# VMSS AZURE MONITOR AGENT
# ============================================================

module "vmss_extension" {
  source = "../../../modules/compute/virtual-machine-scale-set-extension"

  name                         = "ama-linux"
  virtual_machine_scale_set_id = module.linux_virtual_machine_scale_set.id
}