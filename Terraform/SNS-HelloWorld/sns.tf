provider "aws" {
  region = "us-east-2"
  shared_credentials_file = "/Users/johnray/.aws/credentials"
  profile = "bubbleup"
}

resource "aws_sns_topic" "JR" {
  name = "JR"
  tags = var.my_tags
}