provider "aws" {
  region = "ap-south-1"
}

resource "aws_security_group" "node_app_sg" {
  name        = "node_app_sg"
  description = "Allow SSH and HTTP inbound traffic"

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP from anywhere"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "node_app" {
  ami           = "ami-02a2af70a66af6dfb"
  instance_type = "t2.micro"
  key_name      = "Jiitak_Key_Pair"
  vpc_security_group_ids = [aws_security_group.node_app_sg.id]

  tags = {
    Name = "node_app"
  }

  # Install docker and git on the instance
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install docker -y
              sudo service docker start
              sudo usermod -aG docker ec2-user
              sudo yum install git -y
              EOF
}

# Output the public IP address of the EC2 instance
output "node_app_ip" {
  value = aws_instance.node_app.public_ip
}
