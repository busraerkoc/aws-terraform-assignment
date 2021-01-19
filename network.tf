resource "aws_vpc" "new_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.new_vpc.id
  tags = {
    Name = "igw"
  }
}
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.new_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.new_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.new_vpc.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true
  tags = {
    Name = "Web"
  }
}

resource "aws_subnet" "application_sb" {
  vpc_id     = aws_vpc.new_vpc.id
  cidr_block = var.application_sb_cidr
  tags = {
    Name = "Application"
  }
}

resource "aws_subnet" "database_sb" {
  vpc_id     = aws_vpc.new_vpc.id
  cidr_block = var.database_sb_cidr
  tags = {
    Name = "Database"
  }
}

resource "aws_subnet" "management_sb" {
  vpc_id     = aws_vpc.new_vpc.id
  cidr_block = var.management_sb_cidr
  tags = {
    Name = "Management"
  }
}

resource "aws_route_table_association" "public_rt_assoc" {
  route_table_id = aws_route_table.public_rt.id
  subnet_id      = aws_subnet.public_subnet.id
}

resource "aws_route_table_association" "private_rt_assoc_app" {
  route_table_id = aws_route_table.private_rt.id
  subnet_id      = aws_subnet.application_sb.id
}

resource "aws_route_table_association" "private_rt_assoc_database" {
  route_table_id = aws_route_table.private_rt.id
  subnet_id      = aws_subnet.database_sb.id
}

resource "aws_route_table_association" "private_rt_assoc_management" {
  route_table_id = aws_route_table.private_rt.id
  subnet_id      = aws_subnet.management_sb.id
}

resource "aws_eip" "nat_gw_eip" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_gw_eip.id
  subnet_id     = aws_subnet.public_subnet.id
}