#=========================================================
# VPC
#=========================================================
resource "aws_vpc" "main" {
  cidr_block       = "${var.cidr_vpc}.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = var.app_name
  }
}

#=========================================================
# Subnet
#=========================================================
resource "aws_subnet" "main-public-a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "${var.cidr_vpc}.1.0/24"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "${var.app_name}-public-a"
  }
}

resource "aws_subnet" "main-public-c" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "${var.cidr_vpc}.2.0/24"
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "${var.app_name}-public-c"
  }
}

#=========================================================
# Internet Gateway
#=========================================================
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.app_name
  }
}

#=========================================================
# Route table
#=========================================================
resource "aws_route_table" "main-public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "${var.app_name}-public"
  }
}

resource "aws_route_table_association" "main-public-a" {
  route_table_id = aws_route_table.main-public.id
  subnet_id      = aws_subnet.main-public-a.id
}

resource "aws_route_table_association" "main-public-c" {
  route_table_id = aws_route_table.main-public.id
  subnet_id      = aws_subnet.main-public-c.id
}
