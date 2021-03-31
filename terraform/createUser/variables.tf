variable "aws_region" {
  type = string
  description = "AWS region to launch servers."
}

variable "aws_zone" {
  type = string
  description = "AWS zone to create subnet."
}

variable "access_key" {
  type = string
  description = "Access key for AWS"
}

variable "secret_key" {
  type = string
  description = "Secret key for AWS"
}

variable "profile" {
    default = "developers"
}

variable "username"{
    default = "Tanya"
}
