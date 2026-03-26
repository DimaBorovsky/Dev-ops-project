terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.81.0"
    }
  }
}
provider "aws" {
  shared_config_files = [" ~/.aws/credentials"]
  shared_credentials_files = [" ~/.aws/credentials"]

}