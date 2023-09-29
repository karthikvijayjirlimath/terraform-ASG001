provider "aws" {
  region = "us-west-1"
}

resource "aws_launch_template" "casper_launch_template" {

  instance_type = "t2.micro"
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
  }
}

