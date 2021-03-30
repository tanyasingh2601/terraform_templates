variable "aws_region" {
    type = string
    default = "us-east-1"
}

variable "aws_availability_zoneA" {
    default = "us-east-1a"
}

variable "aws_availability_zoneB" {
    default = "us-east-1b"
}

variable "instance_ami" {
    type = string
    default = "ami-03d315ad33b9d49c4"
}

# variable "bastion-instance-ami" {
#     type = string
#     default = ""
# }

variable "instance-type" {
    type = string
    default = "t2.micro"
}

variable "vpc_cidr" {
    type = string
    default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
    type = string
    default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
    type = string
    default = "10.0.2.0/24"
}

variable "PRIVATE_KEY_PATH_WEB" {
  default = "~/Downloads/terraform-default.pem"
}

# variable "PUBLIC_KEY_PATH_WEB" {
#   default = "~/london-region-key-pair-web.pub"
# }

# variable "PRIVATE_KEY_PATH_BACKEND" {
#   default = "~/london-region-key-pair-backend"
# }

# variable "PUBLIC_KEY_PATH_BACKEND" {
#   default = "~/london-region-key-pair-backend.pub"
# }

variable "EC2_USER" {
  default = "ubuntu"
}

variable "profile"{
    type = string
    default = "developer"
}

# variable "resource_count" {
#   type = map
#   default = {
#     "developer"  = 1
#     "tester" = 1
#     "production" = 2
#   }
# }