# create a virtual machine and a public IP address


resource "azurerm_public_ip" "public-work" {
  name                = "public-work"
  location            = var.location_name
  resource_group_name = var.vm_resource_group_name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "azure-network" {
  name = "azure-network"
  location = var.location_name
  resource_group_name = var.vm_resource_group_name

  ip_configuration {
    name = "myNICconfig"
    subnet_id = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.public-work.id

  }
}

resource "azurerm_network_interface_security_group_association" "associate" {
  network_interface_id      = azurerm_network_interface.azure-network.id
  network_security_group_id = var.nsg_id
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                            = var.vm_name
  location                        = var.location_name
  resource_group_name             = var.vm_resource_group_name
  size                            = var.vm_size
  admin_username                  = var.vm_username
  admin_password                  = var.vm_password
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.azure-network.id]

  admin_ssh_key {
    public_key = file("./id_rsa.pub")
    username   = var.vm_username
  }


  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}

  resource "null_resource" "ansible_inventory" {
    provisioner "local-exec" {
      command = <<-EOT
     echo "[target]" > inventory_generated.ini
     echo "${azurerm_linux_virtual_machine.vm.public_ip_address} ansible_ssh_user=ekansh-ubuntu" >> inventory_generated.ini
  EOT
      working_dir = "./modules/vm"
    }
  }
  resource "null_resource" "ansible_playbook" {
    provisioner "local-exec" {
      command = "ansible-playbook -i inventory_generated.ini ftp-server1.yaml "
      working_dir = "./modules/vm"

    }
      depends_on = [null_resource.ansible_inventory]
  }



# ansible-galaxy install -r requirements.yml



# ansible-playbook -i inventory.ini ./modules/vm/ftp-server1.yaml
