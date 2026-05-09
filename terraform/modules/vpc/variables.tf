variable "vpc_cidr" {
    type = string
    description = "The CIDR block for VPC"
}

variable "environment" {
    type = string
    description = "Name of environment ex: dev or prod"
}

variable "azs" {
    type = list(string)
    description = "List of Availability Zones"
}

variable "public_subnets" {
    type = list(string)
}

variable "private_subnets" {
    type = list(string)
}