terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
        source="hashicorp/aws"
        version="~> 3.0"
    }
  }
}

provider "aws" {
  profile = "DevOpsUser"
shared_credentials_file = "$HOME/.aws/creds"
region = "ap-southeast-1"
}
