variable prefix{
    description = "This is a prefix added to new resource being added"
    default = "SBAtf"
}

variable location{
    description = "Specifies the Azure Region where the Virtual Machine exists. Changing this forces a new resource to be created."
}

variable rg{
    description = "Specifies the name of the Resource Group in which the Virtual Machine should exist. Changing this forces a new resource to be created."
}

variable network_id{
    description = "A list of Network Interface ID's which should be associated with the Virtual Machine."
}

variable os {
    description = "Enter win for windows or linux for a linux vm"
}

variable name{
    description = "Specifies the name of the Virtual Machine."
}

variable username{
    description = "Specifies the name of the local administrator account"
}

variable password{
    description = "    The password associated with the local administrator account."
}

variable disk_type{
    description = "Specifies the type of managed disk to create. Possible values are either Standard_LRS, StandardSSD_LRS, Premium_LRS or UltraSSD_LRS."
}


variable publisher { 
    default ={
        win = "MicrosoftWindowsServer"
        linux = "Canonical"
    }
}
    
variable offer {
    default = {
        win = "WindowsServer"
        linux = "UbuntuServer"
    }
}     

variable sku {
    default = {
        win = "2016-Datacenter" 
        linux = "16.04.0-LTS"
    }
}      
 
variable ver {
    default = "latest"
}

variable storage_uri { 
    description = "The Storage Account's Blob Endpoint which should hold the virtual machine's diagnostic files."
}

variable subnet_id {
    description = "Reference to a subnet in which this NIC has been created. Required when private_ip_address_version is IPv4."
}