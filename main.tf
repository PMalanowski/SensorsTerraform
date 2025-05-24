provider "aws" {
  region = "us-east-1"
}

provider "archive" {}

data "aws_iam_role" "main_role" {
    name = "LabRole"
}


