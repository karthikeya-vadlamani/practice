module "vpc_dev" {
  source = "../../modules/vpc"

  # We pass variables from our tfvars file into the module
  environment     = var.environment
  vpc_cidr        = var.vpc_cidr
  azs             = var.azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}

# You need to define these variables here so main.tf knows they exist
variable "environment" {}
variable "vpc_cidr" {}
variable "azs" { type = list(string) }
variable "public_subnets" { type = list(string) }
variable "private_subnets" { type = list(string) }
