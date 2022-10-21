########################################
########## REMOTE BACKENDS & PROVIDERS
########################################
terraform {
  backend "s3" {
    key            = "dummy.tfstate"
    dynamodb_table = "terraform-state-locking"
  }

  required_version = "0.12.31"
}

provider "aws" {
  region  = var.target_region
  version = "3.38.0"
}

provider "template" {
  version = "~> 2.1"
}

########################################
########## LOCALS
########################################
locals {
  service_name = "dummy"
  common_tags = {
    Name            = "dummy"
    Contact         = "snjy991@gmail.com"
  }
  LastModifiedTime = timestamp()
  LastModifiedBy   = data.aws_caller_identity.current.arn
}
