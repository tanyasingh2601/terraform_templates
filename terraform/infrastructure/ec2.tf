resource "aws_instance" "prod-web" {
    # count = var.resource_count[var.profile]
    ami = var.instance_ami
    instance_type = var.instance-type
    subnet_id = aws_subnet.prod-subnet-public.id
    vpc_security_group_ids = [ aws_security_group.prod-public-sg.id ]
    key_name = "terraform-default"
    provisioner "remote-exec" {
        inline = [
             "sudo apt-get update",
             "sudo apt-get install apache2 -y"
        ]
    }
    connection {
        host = self.public_ip
        user = var.EC2_USER
        private_key = file(var.PRIVATE_KEY_PATH_WEB)
    }
    tags = {
      Name = join("-", [var.suffix, "web"])
      Environment = join("-", [var.profile, "environment"])
    }
}


resource "aws_instance" "prod-bastion" {
  ami           = var.instance_ami
  instance_type = var.instance-type

  subnet_id = aws_subnet.prod-subnet-public.id

  vpc_security_group_ids = [ aws_security_group.prod-private-sg.id ]

  key_name = "terraform-default"

  tags = {
      Name = join("-", [var.suffix, "bastion"])
      Environment = join("-", [var.profile, "environment"])
    }
}

resource "aws_instance" "prod-backend" {
    # count = var.resource_count[var.profile]
    ami = var.instance_ami
    instance_type = var.instance-type
    subnet_id = aws_subnet.prod-subnet-private.id
    vpc_security_group_ids = [ aws_security_group.prod-private-sg.id ]
    key_name = "terraform-default"

    tags = {
      Name = join("-", [var.suffix, "backend"])
      Environment = join("-", [var.profile, "environment"])
    }
}
