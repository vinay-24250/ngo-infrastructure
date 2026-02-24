provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "ngo_server" {
  ami           = "ami-0f5ee92e2d63afc18"   # Ubuntu 22.04 (ap-south-1)
  instance_type = "t3.micro"
  key_name      = "ngo-key"

  security_groups = [aws_security_group.ngo_sg.name]

  tags = {
    Name = "NGO-DevOps-Server"
  }
}

resource "aws_security_group" "ngo_sg" {
  name = "ngo-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
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

output "public_ip" {
  value = aws_instance.ngo_server.public_ip
}