provider "aws" {
  region = "us-west-1"
}

data "aws_ami" "Amazon_Linux" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

resource "aws_launch_configuration" "capser_launch_configuration" {
  image_id = data.aws_ami.Amazon_Linux.image_id
  instance_type = "t2.nano"
  associate_public_ip_address = true
}

output "Amazon_linux" {
  description = "Amazon Linux imageID"
  value = aws_launch_configuration.capser_launch_configuration.name
}

