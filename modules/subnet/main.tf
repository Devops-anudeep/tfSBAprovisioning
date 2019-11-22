resource "azurerm_subnet" "test" {
  name                 = "internal"
  resource_group_name  = "rg-sba-terraformout"
  virtual_network_name = "rg-sba-terraformout-vnet"
  address_prefix       = "10.1.0.0/24"
}
output "subnet_id"{
  value = azurerm_subnet.test.id
}
