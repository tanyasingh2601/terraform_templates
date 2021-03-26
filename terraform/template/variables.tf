variable "ami" {
  type = string
  default = "ami-0915bcb5fa77e4892"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "subnet_id" {
  type = string
  default = "subnet-2e143663"
}

variable "security_groups" {
  default = ["sg-084a0ee96cd94f837"]
}

# variable "key" {
#   type = string
#   default = "shubham-key12345"
# }