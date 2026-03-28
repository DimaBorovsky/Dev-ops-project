resource "aws_vpc" "project-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "terraformVPC"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.project-vpc.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_subnet" "private-subnet" {
  vpc_id = aws_vpc.project-vpc.id
  cidr_block = "10.0.2.0/24"
}


resource "aws_internet_gateway" "tf-igw" {
  vpc_id = aws_vpc.project-vpc.id

}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.project-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf-igw.id
  }
}


resource "aws_route_table_association" "public-rta" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}