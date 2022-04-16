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
    organization = "ggamsoon2"

    workspaces {
      name = "tf-aws-ec2-git-action"
    }
  }
}
