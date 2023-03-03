# Variable that holds the CIDR block for the VPC
variable "vpc_cidr_block" {
  description = "CIDR block of the VPC"
}
# Variable that holds the CIDR block for the public subnet
variable "public_subnet_cidr_block" {
  description = "CIDR block of the public subnet"
}