# Variable where we will pass in the ID of our VPC
variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

# Variable where we will pass in our IP address from the secrets file
variable "my_ip" {
  description = "My IP address"
  type        = string
}