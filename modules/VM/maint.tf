# Create a Linux virtual machine
resource "azurerm_virtual_machine" "vm" {
  name                  = "${var.prefix}"
  location              = "${var.location}"
  resource_group_name   = "${var.rg}"
  network_interface_ids = "${var.network_id}"
  vm_size               = "Standard_B1ms"

  # This means the OS Disk will be deleted when Terraform destroys the Virtual Machine
  # NOTE: This may not be optimal in all cases.
  delete_os_disk_on_termination = true

  storage_os_disk {
    name              = "${var.prefix}-OsDisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "${var.disk_type}"
  }

  storage_image_reference {
    publisher = lookup(var.publisher, var.os)
    offer     = lookup(var.offer, var.os)
    sku       = lookup(var.sku, var.os)
    version   = "${var.version}"
  }

  os_profile {
    computer_name  = "${var.name}"
    admin_username = "${var.username}"
    admin_password = "${var.password}"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}
