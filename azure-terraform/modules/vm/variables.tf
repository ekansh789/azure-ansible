variable "vm_name" {
  type        = string
  default =  "vm"
}

variable "location_name" {
  type    = string
  default = "southeast Asia"
}

variable "vm_resource_group_name" {
  type    = string
  default = "sa1_test_eic_TejalDave"
}

variable "vm_size" {
    type = string
    default = "Standard_B2ms"
}

variable "vm_username" {
    type = string 
      default = "ekansh-ubuntu"

} 

variable "vm_password" {
    type = string
    default = "Complex@password1"
}

variable "nsg_id" {}

variable "subnet_id" {}
