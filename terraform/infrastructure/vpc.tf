# Specify the provider and access details
provider "aws" {
  region = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_vpc" "prod-vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support = "true" 
  enable_dns_hostnames = "true" 
  enable_classiclink = false
  instance_tenancy = "default"
  tags = {
      Name = join("-", [var.suffix, "vpc"])
      Environment = join("-", [var.profile, "environment"])
    }
}

