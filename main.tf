provider "aws" {
  region = var.aws_region
}

module "network" {
  source = "./modules/network"

  aws_region            = var.aws_region
  vpc_cidr              = var.vpc_cidr
  public_subnet_cidr_1  = var.public_subnet_cidr_1
  public_subnet_cidr_2  = var.public_subnet_cidr_2
  private_subnet_cidr_1 = var.private_subnet_cidr_1
  private_subnet_cidr_2 = var.private_subnet_cidr_2
  availability_zone_1   = var.availability_zone_1
  availability_zone_2   = var.availability_zone_2
  tags                  = var.tags
  allowed_ip            = var.allowed_ip
}

module "compute" {
  source = "./modules/compute"

  instance_type       = "c7i.xlarge"
  key_name            = var.key_name
  public_subnet_id    = module.network.public_subnet_id_1
  private_subnet_id_1 = module.network.private_subnet_id_1
  private_subnet_id_2 = module.network.private_subnet_id_2
  security_group_id   = module.network.security_group_id
  tags                = var.tags
  depends_on          = [module.network]
}

module "loadbalancer" {
  source = "./modules/loadbalancer"

  vpc_id              = module.network.vpc_id
  public_subnet_ids          = [
    module.network.public_subnet_id_1,
    module.network.public_subnet_id_2
  ]
  target_instance_ids = {
    web1 = module.compute.webfront_vm_1_id
    web2 = module.compute.webfront_vm_2_id
  }
  acm_certificate_arn = module.certificates.certificate_arn
  tags                = var.tags
  depends_on          = [module.compute]
}

module "certificates" {
  source      = "./modules/certificates"
  full_domain = "quotestorm.desire-projects.com"
  validation_record_fqdns = module.route53.validation_record_fqdns
  tags        = var.tags
}

module "route53" {
  source                  = "./modules/route53"
  domain_name             = "desire-projects.com"
  domain_validation_options = module.certificates.domain_validation_options 
  alias_record_name = "quotestorm.desire-projects.com"
  alb_dns_name      = module.loadbalancer.alb_dns_name
  alb_zone_id       = module.loadbalancer.alb_zone_id
}

