# Creting the VPC and calling it tutorial_vpc
resource "aws_vpc" "tutorial_vpc" {
  # Setting the CIDR block of the VPC to the variable vpc_cidr_block
  cidr_block = var.vpc_cidr_block

  # Enabling DNS hostnames on the VPC
  enable_dns_hostnames = true

  # Setting the tag Name to tutorial_vpc
  tags = {
    Name = "tutorial_vpc"
  }
}

# Creating the Internet Gateway and naming it tutorial_igw
resource "aws_internet_gateway" "tutorial_igw" {
  # Attaching it to the VPC called tutorial_vpc
  vpc_id = aws_vpc.tutorial_vpc.id

  # Setting the Name tag to tutorial_igw
  tags = {
    Name = "tutorial_igw"
  }
}

# Creating the public route table and calling it tutorial_public_rt
resource "aws_route_table" "tutorial_public_rt" {
  # Creating it inside the tutorial_vpc VPC
  vpc_id = aws_vpc.tutorial_vpc.id

  # Adding the internet gateway to the route table
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tutorial_igw.id
  }
}

# Data store that holds the available AZs in our region
data "aws_availability_zones" "available" {
  state = "available"
}

# Creating the public subnet and naming it tutorial_public_subnet
resource "aws_subnet" "tutorial_public_subnet" {
  # Creating it inside the tutorial_vpc VPC
  vpc_id = aws_vpc.tutorial_vpc.id

  # Setting the CIDR block to the variable public_subnet_cidr_block
  cidr_block = var.public_subnet_cidr_block

  # Setting the AZ to the first one in our available AZ data store
  availability_zone = data.aws_availability_zones.available.names[0]

  # Setting the tag Name to "tutorial_public_subnet"
  tags = {
    Name = "tutorial_public_subnet"
  }
}

# Associating our public subnet with our public route table
resource "aws_route_table_association" "public" {
  # The ID of our public route table called tutorial_public_rt
  route_table_id = aws_route_table.tutorial_public_rt.id

  # The ID of our public subnet called tutorial_public_subnet
  subnet_id = aws_subnet.tutorial_public_subnet.id
}