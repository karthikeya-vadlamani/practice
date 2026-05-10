# GET LATEST AMAZON LINUX AMI

data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name = "name"

    values = ["al2023-ami-2023.*-x86_64"]
  }
}

# SECURITY GROUP

resource "aws_security_group" "ec2_sg" {
  name        = "dev-ec2-sg"
  description = "Allow SSH access"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"

    from_port = 22
    to_port   = 22

    protocol = "tcp"

    cidr_blocks = [var.allowed_ssh_cidr]
  }

  egress {
    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "dev-ec2-sg"
  }
}

# EC2 INSTANCE

resource "aws_instance" "main" {
  ami = data.aws_ami.amazon_linux.id

  instance_type = "t3.micro"

  subnet_id = var.public_subnet_id

  vpc_security_group_ids = [
    aws_security_group.ec2_sg.id
  ]

  associate_public_ip_address = true

  key_name = var.key_name

  tags = {
    Name = "dev-ec2"
  }
}