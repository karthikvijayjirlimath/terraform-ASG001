terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.20"
    }
  }
}

provider "aws" {
    region = "us-west-1"
}

resource "aws_iam_user" "casper_iam" {
   name = "casper_iam"
   path = "/system/"

   tags = {
    environment = "test"
   }
}

data "aws_iam_policy_document" "casper_policy" {
  version = "2012-10-17"
  
  statement {
    sid = "AWS IAM overprivileged access"
    principals {
      type = "AWS"
      identifiers = ["${aws_iam_user.casper_iam.arn}"]
    }
    effect    = "Allow"
    actions   = ["*"]
    resources = ["*"]
    
  }
}

resource "aws_iam_user_policy" "casper_testing_policy" {
  name = "casper_check_policy"
  user = aws_iam_user.casper_iam.name

  policy = data.aws_iam_policy_document.casper_policy.json
}
