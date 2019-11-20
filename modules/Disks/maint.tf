  
locals {  
  number_of_disks = 2
}

resource "azurerm_managed_disk" "external" {
  count                = "${local.number_of_disks}"
  name                 = "${var.prefix}-disk${count.index+1}"
  location             = "${var.location}"
  resource_group_name  = "${var.rg}"
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "10"
}

resource "azurerm_virtual_machine_data_disk_attachment" "external" {
  count              = "${local.number_of_disks}"
  managed_disk_id    = "${azurerm_managed_disk.external.*.id[count.index]}"
  virtual_machine_id = "${var.virtual_machine_id}"
  lun                = "${10+count.index}"
  caching            = "ReadWrite"
}