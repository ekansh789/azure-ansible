# create a network security group and rules

resource "azurerm_network_security_group" "Linux-nsg" {
  name                      = "Linux-nsg"
  location                  = var.nsg_location
  resource_group_name = var.nsg_resource_group_name

  security_rule {
    name                       = "allow_ssh"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"

  }

  security_rule {
    name = "Allow_FTP"
    priority = 1002
    direction =  "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "21"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}




