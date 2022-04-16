terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    random = {
      source = "hashicorp/random"
    }
  }

  cloud {
    organization = "ggamsoon2"

    workspaces {
      name = "tf-aws-ec2-git-action"
    }
  }
}

resource "aws_vpc" "my-private-vpc-01" {
  cidr_block           = "10.255.0.0/16" 
  enable_dns_hostnames = false 

  tags = {
    Name    = "private_vpc"
  }
}

resource "aws_subnet" "my-private-subnet-01" {
  vpc_id                  = aws_vpc.my-private-vpc-01.id
  cidr_block              = "10.255.10.0/24"
  availability_zone       = "ap-northeast-2a" 

  tags = {
    Name = "private_subnet"
  }
}

resource "aws_security_group" "default_in_allow_ssh" {
  name        = "allow_ssh"
  description = "Allow ssh inbound traffic"
  vpc_id      = aws_vpc.my-private-vpc-01.id 

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow"
  }
}

provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_instance" "terrafrom-ec2" {
  ami                         = "ami-0ed11f3863410c386"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.my-private-subnet-01.id 
  security_groups             = [aws_security_group.default_in_allow_ssh.id]
  tags 			      = {
    Name = "Terraform-aws-ec2"
  }
}
