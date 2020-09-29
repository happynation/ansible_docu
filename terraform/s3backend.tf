terraform {
  backend "s3" {
    bucket = "backend-state-vova"
    key    = "path/to/my/key"
    region = "us-east-1"
    dynamodb_table = "terra-tf"
  }
}