module "vpc" {
  source = "./modules/vpc"

  vpc_cidr              = var.vpc_cidr
  public_subnet_cidr    = var.public_subnet_cidr
  private_subnet_1_cidr = var.private_subnet_1_cidr
  private_subnet_2_cidr = var.private_subnet_2_cidr
}

module "rds" {
  source = "./modules/rds"

  private_subnet_ids = module.vpc.private_subnet_ids

  vpc_id = module.vpc.vpc_id

  db_username = var.db_username
  db_password = var.db_password

  allowed_cidr = "10.0.0.0/16"
}

module "ec2" {
  source = "./modules/ec2"

  vpc_id = module.vpc.vpc_id

  public_subnet_id = module.vpc.public_subnet_id

  key_name = var.key_name

  allowed_ssh_cidr = var.allowed_ssh_cidr
}