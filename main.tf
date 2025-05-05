provider "aws" {
  region = var.aws_region
}

module "network" {
  source = "./modules/network"

  aws_region            = var.aws_region
  vpc_cidr              = var.vpc_cidr
  public_subnet_cidr    = var.public_subnet_cidr
  private_subnet_cidr_1 = var.private_subnet_cidr_1
  private_subnet_cidr_2 = var.private_subnet_cidr_2
  availability_zone_1   = var.availability_zone_1
  availability_zone_2   = var.availability_zone_2
  tags                  = var.tags
  allowed_ip            = var.allowed_ip
}

module "compute" {
  source = "./modules/compute"

  instance_type       = "t3.micro"
  key_name            = var.key_name
  public_subnet_id    = module.network.public_subnet_id
  private_subnet_id_1 = module.network.private_subnet_id_1
  private_subnet_id_2 = module.network.private_subnet_id_2
  security_group_id   = module.network.security_group_id
  tags                = var.tags
}

module "loadbalancer" {
  source = "./modules/loadbalancer"

  vpc_id              = module.network.vpc_id
  subnet_ids          = [
    module.network.private_subnet_id_1,
    module.network.private_subnet_id_2
  ]
  target_instance_ids = [
    module.compute.webfront_vm_1_id,
    module.compute.webfront_vm_2_id
  ]
  tags                = var.tags
}
