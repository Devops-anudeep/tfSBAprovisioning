variable prefix{
    description = "This is a prefix added to new resource being added"
}

variable location{
    description = "Specifies the Azure Region where the Virtual Machine exists. Changing this forces a new resource to be created."
}

variable rg{
    description = "Specifies the name of the Resource Group in which the Virtual Machine should exist. Changing this forces a new resource to be created."
}

variable virtual_machine_id{
    description = "The ID of the Virtual Machine to which the Data Disk should be attached. Changing this forces a new resource to be created."
}

variable number_of_disks{
    description = "Number of disks to be created and attached to the virtual machine"
}


