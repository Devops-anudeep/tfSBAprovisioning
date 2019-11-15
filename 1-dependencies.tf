locals {
  virtual_machine_name = "${var.prefix}-vm"
  admin_username       = "testadmin"
  admin_password       = "Password1234!"
}

resource "azurerm_resource_group" "example" {
  name     = "SBAtfTestGroup"
  location = "${var.location}"
}

resource "azurerm_virtual_network" "example" {
  name                = "${var.prefix}-vnet"
  address_space       = ["10.0.0.0/24"]
  location            = "${azurerm_resource_group.example.location}"
  resource_group_name = "${azurerm_resource_group.example.name}"
}

resource "azurerm_subnet" "example" {
  name                 = "internal"
  resource_group_name  = "${azurerm_resource_group.example.name}"
  virtual_network_name = "${azurerm_virtual_network.example.name}"
  address_prefix       = "10.0.2.0/26"
}

resource "azurerm_public_ip" "example" {
  name                = "${var.prefix}-publicip"
  resource_group_name = "${azurerm_resource_group.example.name}"
  location            = "${azurerm_resource_group.example.location}"
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "example" {
  name                = "${var.prefix}-nic"
  location            = "${azurerm_resource_group.example.location}"
  resource_group_name = "${azurerm_resource_group.example.name}"

  ip_configuration {
    name                          = "configuration"
    subnet_id                     = "${azurerm_subnet.example.id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${azurerm_public_ip.example.id}"
  }
}
