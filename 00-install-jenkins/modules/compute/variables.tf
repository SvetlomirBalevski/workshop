# Variable where we will pass our Jenkins security group ID 
variable "security_group" {
  description = "The security groups assigned to the Jenkins server"
}

# Variable where we will pass in the subnet ID
variable "public_subnet" {
  description = "The public subnet IDs assigned to the Jenkins server"
}