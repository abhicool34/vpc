resource "aws_vpc" "vpc" {
  cidr_block = data.terraform_remote_state.vpc.outputs.vpc_cidr
  tags = {
    Name = "${var.environment_name}-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = data.terraform_remote_state.vpc.outputs.public_subnet_cidr
  availability_zone = data.terraform_remote_state.vpc.outputs.public_subnet_az
  tags = {
    Name = "${var.environment_name}-public-subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.environment_name}-example-igw"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.environment_name}-route-table"
  }
}

resource "aws_route_table_association" "example_association" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.route_table.id
}

