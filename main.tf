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

provider "aws" {
  region     = "ap-northeast-2"
}

resource "aws_instance" "terrafrom-ec2" {
  ami           = "ami-0ed11f3863410c386"
  instance_type = "t2.micro"
  subnet_id = "subnet-0999184b37219db7d"
  associate_public_ip_address = "true"
  security_groups = ["sg-078cf2eafc71b9688"]
}

resource "aws_security_group" "default_in_allow_ssh" {
  name        = "allow_ssh"
  description = "Allow ssh inbound traffic"
  vpc_id      = "vpc-07dea6e36a1320411" 

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow"
  }
}
