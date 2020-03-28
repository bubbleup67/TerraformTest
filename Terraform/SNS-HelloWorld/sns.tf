provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

resource "aws_sns_topic" "JR" {
  name = "JR"
}