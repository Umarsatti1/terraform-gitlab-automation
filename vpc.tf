# Create VPC
resource "aws_vpc" "main_vpc" {
  cidr_block       = "10.0.0.0/20"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "MyMainVPC"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "InternetGateway"
  }
}

# Create Subnets
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = var.availability_zone

  tags = {
    Name = "MyPublicSubnet"
  }
}

# Create Route Table
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "MyPublicRouteTable"
  }
}

# Create Route Table Association
resource "aws_route_table_association" "association" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.route_table.id
  depends_on = [ aws_route_table.route_table ]
}


# Create Security Group
resource "aws_security_group" "my_security_group"{
    name = var.sg_name
    description = "Security group created using Terraform"
    vpc_id = aws_vpc.main_vpc.id

    # Inbound rules
    ingress {
        cidr_blocks = ["0.0.0.0/0"]
        from_port = 22
        to_port = 22
        protocol = "tcp"
        description = "Provides inbound SSH access"
    }

    ingress {
        cidr_blocks = ["0.0.0.0/0"]
        from_port = 80
        to_port = 80
        protocol = "tcp"
        description = "Provides inbound HTTP access"
    }

    ingress {
        cidr_blocks = ["0.0.0.0/0"]
        from_port = 443
        to_port = 443
        protocol = "tcp"
        description = "Provides inbound HTTPS access"
    }

    # Outbound rules
    egress {
        cidr_blocks = ["0.0.0.0/0"]
        from_port = 0
        to_port = 0
        protocol = "-1"
        description = "Provides outbound access everywhere"
    }

    tags = {
        Name = var.sg_name
    }
}