resource "azurerm_linux_virtual_machine_scale_set" "linux_vmss" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  sku       = var.sku
  instances = var.instances

  admin_username = var.admin_username

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.admin_ssh_public_key
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.os_disk_storage_account_type
  }

  upgrade_mode = "Automatic"

  identity {
    type = "SystemAssigned"
  }

  network_interface {
    name = "${var.name}-nic"

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = var.subnet_id
    }
  }

  tags = var.tags
}