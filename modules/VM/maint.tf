# Create a Linux virtual machine
resource "azurerm_virtual_machine" "vm" {
  name                  = var.prefix
  location              = var.location
  resource_group_name   = var.rg
  network_interface_ids = ["${azurerm_network_interface.vm.id}"]
  vm_size               = "Standard_B1ms"

  # This means the OS Disk will be deleted when Terraform destroys the Virtual Machine
  # NOTE: This may not be optimal in all cases.
  delete_os_disk_on_termination = true

  storage_os_disk {
    name              = "${var.prefix}-OsDisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = var.disk_type
  }

  storage_image_reference {
    publisher = lookup(var.publisher, var.os)
    offer     = lookup(var.offer, var.os)
    sku       = lookup(var.sku, var.os)
    version   = var.ver
  }

  os_profile {
    computer_name  = var.name
    admin_username = var.username
    admin_password = var.password
  }

  os_profile_windows_config {
    provision_vm_agent = true
  }
  // os_profile_linux_config {
  //   disable_password_authentication = false
  // }
}

resource "azurerm_network_interface" "vm" {
  name                = "${var.prefix}-nic"
  location            = var.location
  resource_group_name = var.rg

  ip_configuration {
    name                          = "configuration"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine_extension" "MYADJOINEDVMADDE" {
  name                 = "MYADJOINEDVMADDE"
  location             = var.location
  resource_group_name  = var.rg
  virtual_machine_name = azurerm_virtual_machine.vm.name
  publisher            = "Microsoft.Compute"
  type                 = "JsonADDomainExtension"
  type_handler_version = "1.3"

  # What the settings mean: https://docs.microsoft.com/en-us/windows/desktop/api/lmjoin/nf-lmjoin-netjoindomain

  settings = <<SETTINGS
    {
        "Name": "SBATEST.COM",
        "OUPath": "OU=servers,DC=sbatest,DC=com",
        "User": "sbatest.com\\sbatest",
        "Restart": "true",
        "Options": "3"
    }
SETTINGS
  protected_settings = <<PROTECTED_SETTINGS
    {
      "Password": "$BAtesting2019"
    }
  PROTECTED_SETTINGS
  depends_on = ["azurerm_virtual_machine.vm"]
}