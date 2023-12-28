
module "vnet" {
  source    = "./modules/vnet"
  
}

module "nsg" {
  source = "./modules/nsg"

}

module "vm" {
  source  = "./modules/vm"
  nsg_id = module.nsg.nsg_id
  subnet_id = module.vnet.subnet_id
}


