# This data store is holding the most recent ubuntu 20.04 image
data "aws_ami" "ubuntu" {
  most_recent = "true"

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

# Creating an EC2 instance called jenkins_server
resource "aws_instance" "jenkins_server" {
  # Setting the AMI to the ID of the Ubuntu 20.04 AMI from the data store
  ami = data.aws_ami.ubuntu.id

  # Setting the subnet to the public subnet we created
  subnet_id = var.public_subnet

  # Setting the instance type to t2.micro
  instance_type = "t2.micro"

  # Setting the security group to the security group we created
  vpc_security_group_ids = [var.security_group]

  # Setting the key pair name to the key pair we created
  key_name = aws_key_pair.tutorial_kp.key_name

  # Setting the user data to the bash file called install_jenkins.sh
  user_data = file("${path.module}/install_jenkins.sh")

  # Setting the Name tag to jenkins_server
  tags = {
    Name = "jenkins_server"
  }
}

# Creating a key pair in AWS called tutorial_kp
resource "aws_key_pair" "tutorial_kp" {
  # Naming the key tutorial_kp
  key_name = "tutorial_kp"

  # Passing the public key of the key pair we created
  public_key = file("${path.module}/tutorial_kp.pub")
}

# Creating an Elastic IP called jenkins_eip
resource "aws_eip" "jenkins_eip" {
  # Attaching it to the jenkins_server EC2 instance
  instance = aws_instance.jenkins_server.id

  # Making sure it is inside the VPC
  vpc = true

  # Setting the tag Name to jenkins_eip
  tags = {
    Name = "jenkins_eip"
  }
}