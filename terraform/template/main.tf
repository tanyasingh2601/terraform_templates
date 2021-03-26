resource "aws_instance" "instance" {
  ami             = var.ami
  instance_type   = var.instance_type
  subnet_id       = var.subnet_id
  # key_name        = var.key
  user_data       = data.template_file.script.rendered
  security_groups = var.security_groups
tags = {
    Name      = "EFS_TEST"
    Terraform = "true"
  }
volume_tags = {
    Name      = "EFS_TEST_ROOT"
    Terraform = "true"
  }
}
resource "aws_efs_file_system" "efs" {
  creation_token   = "EFS Shared Data"
  performance_mode = "generalPurpose"
tags = {
    Name = "EFS Shared Data"
  }
}
resource "aws_efs_mount_target" "efs" {
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = var.subnet_id
  security_groups = var.security_groups
}
data "template_file" "script" {
  template = file("script.tpl")
  vars = {
    efs_id = aws_efs_file_system.efs.id
  }
}
