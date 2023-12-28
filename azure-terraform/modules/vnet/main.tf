# create a virtual network and a subnet

resource "azurerm_virtual_network" "work-vnet" {
name = "work-vnet"
location = var.vnet_location
resource_group_name = var.vnet_resource_group_name
address_space = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "Subnet_azure" {
name = "Subnet_azure"
resource_group_name = var.vnet_resource_group_name
virtual_network_name = azurerm_virtual_network.work-vnet.name
address_prefixes = ["10.0.0.0/24"]
}

#output for subnet id 
