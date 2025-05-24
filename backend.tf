terraform {
  backend "s3" {
    bucket         = "sensors-terraform-state-bucket-12345"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks-table"
    encrypt        = true
  }
}
