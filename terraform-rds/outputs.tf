output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_id" {
  value = module.vpc.public_subnet_id
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

output "rds_endpoint" {
  value = module.rds.rds_endpoint
}

output "ec2_public_ip" {
  value = module.ec2.public_ip
}