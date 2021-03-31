############## PUBLIC SUBNET ###############

resource "aws_subnet" "prod-subnet-public" {
    vpc_id = aws_vpc.prod-vpc.id
    cidr_block = var.public_subnet_cidr
    map_public_ip_on_launch = "true" 
    availability_zone = var.aws_availability_zoneA
    tags = {
      Name = join("-", [var.suffix, "public-subnet"])
      Environment = join("-", [var.profile, "environment"])
    }
}

############## PRIVATE SUBNET ###############

resource "aws_subnet" "prod-subnet-private" {
    vpc_id = aws_vpc.prod-vpc.id
    cidr_block = var.private_subnet_cidr
    map_public_ip_on_launch = "false" 
    availability_zone = var.aws_availability_zoneB
    tags = {
      Name = join("-", [var.suffix, "private-subnet"])
      Environment = join("-", [var.profile, "environment"])
    }
}

################### IGW #####################

resource "aws_internet_gateway" "prod-igw" {
    vpc_id = aws_vpc.prod-vpc.id
    tags = {
      Name = join("-", [var.suffix, "igw"])
      Environment = join("-", [var.profile, "environment"])
    }
}

################### NAT #####################

resource "aws_eip" "prod-nat" {
}

resource "aws_nat_gateway" "prod-natgw" {
    allocation_id = aws_eip.prod-nat.id
    subnet_id = aws_subnet.prod-subnet-public.id
    tags = {
      Name = join("-", [var.suffix, "natgw"])
      Environment = join("-", [var.profile, "environment"])
    }
}

############ PUBLIC ROUTE TABLE ##############

resource "aws_route_table" "prod-public-rt" {
    vpc_id = aws_vpc.prod-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.prod-igw.id
    }
    tags = {
      Name = join("-", [var.suffix, "public-rt"])
      Environment = join("-", [var.profile, "environment"])
    }
}

############ PRIVATE ROUTE TABLE ##############

resource "aws_route_table" "prod-private-rt" {
    vpc_id = aws_vpc.prod-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.prod-natgw.id
    }
    tags = {
      Name = join("-", [var.suffix, "private-rt"])
      Environment = join("-", [var.profile, "environment"])
    }
}

## PUBLIC Subnet association with rotute table ##

resource "aws_route_table_association" "prod-public-asso" {
    subnet_id = aws_subnet.prod-subnet-public.id
    route_table_id = aws_route_table.prod-public-rt.id
}

## PRIVATE Subnet association with rotute table ##

resource "aws_route_table_association" "prod-private-asso" {
    subnet_id = aws_subnet.prod-subnet-private.id
    route_table_id = aws_route_table.prod-private-rt.id
}

############## PUBLIC SECURITY GROUP ###############

resource "aws_security_group" "prod-public-sg" {
    vpc_id = aws_vpc.prod-vpc.id
    egress {
        cidr_blocks = ["0.0.0.0/0"]
        description = "egress rule for outgoing traffic"
        from_port = 0
        protocol = -1
        to_port = 0
    } 
    ingress {
        cidr_blocks = [ "0.0.0.0/0" ]
        description = "ingress rule for ssh"
        from_port = 22
        protocol = "tcp"
        to_port = 22
    }

    ingress {
        cidr_blocks = [ "0.0.0.0/0" ]
        description = "ingress rule for webserver"
        from_port = 80
        protocol = "tcp"
        to_port = 80
    } 

    tags = {
      Name = join("-", [var.suffix, "public-sg"])
      Environment = join("-", [var.profile, "environment"])
    }
}

############## PRIVATE SECURITY GROUP ##############

resource "aws_security_group" "prod-private-sg" {
    vpc_id = aws_vpc.prod-vpc.id
    egress {
        cidr_blocks = ["0.0.0.0/0"]
        description = "egress rule for outgoing traffic"
        from_port = 0
        protocol = -1
        to_port = 0
    } 
    ingress {
        cidr_blocks = [ "0.0.0.0/0" ]
        description = "ingress rule for ssh"
        from_port = 22
        protocol = "tcp"
        to_port = 22
    }

    tags = {
      Name = join("-", [var.suffix, "private-sg"])
      Environment = join("-", [var.profile, "environment"])
    }
}