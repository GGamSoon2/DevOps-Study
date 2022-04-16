form {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    random = {
      source = "hashicorp/random"
    }
  }

  cloud {
    organization = "REPLACE_ME"

    workspaces {
      name = "tf-aws-ec2-git-action"
    }
  }
}
