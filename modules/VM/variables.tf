variable prefix{
    description = "This is a prefix added to new resource being added"
    default = "SBAtf"
}

variable location{
    description = "This is a prefix added to new resource being added"
    default = "East US"
}

variable rg{
    description = "This is a prefix added to new resource being added"
    default = "SBAtf"
}

variable network_id{
    description = "This is a prefix added to new resource being added"
    default = "SBAtf"
}

variable os {
    description = "This variable is set to win for windows or linux for a linux vm"
    default = "linux"
}

variable name{
    description = "This is a prefix added to new resource being added"
    default = "SBAtf"
}

variable username{
    description = "This is a prefix added to new resource being added"
    default = "SBAtf"
}

variable password{
    description = "This is a prefix added to new resource being added"
    default = "SBAtf"
}

variable disk_type{
    description = "This is a prefix added to new resource being added"
    default = "Standard_LRS"
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