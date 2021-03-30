# Specify the provider and access details
provider "aws" {
  region = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_iam_user" "iam_user" {
  name          = var.username
  path          = "/"
  force_destroy = true
}

resource "aws_iam_user_login_profile" "login_profile" {
  user    = aws_iam_user.iam_user.name
  password_reset_required = true
  pgp_key = "keybase:aws_terra_user"
}

resource "aws_iam_access_key" "lb" {
  user    = aws_iam_user.iam_user.name
  pgp_key = "keybase:aws_terra_user"
}

resource "aws_iam_user_group_membership" "user-membership" {
  user   = aws_iam_user.iam_user.name
  groups = [var.profile]
}
