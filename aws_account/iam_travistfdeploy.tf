# IAM User
resource "aws_iam_user" "service_travis_tfdeploy" {
  name = "service_travis_tfdeploy"
}

# IAM Policy
resource "aws_iam_policy" "service_travis_tfdeploy" {
  name        = "tf-service_travis_tfdeploy_policy"
  description = "Travis CI Terraform Deployment Policy - Managed by Terraform @ terraform-cjbischoff/tf-aws-account"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "*",
      "Resource": "*"
    }
  ]
}
EOF
}

module "sliplab-tf-service_travis_tfdeploy-group" {
  source      = "git::https://github.com/michalschott/tf-aws-iam-group.git?ref=master"
  name        = "sliplab-tf-service_travis_tfdeploy-group"
  membership  = ["service_travis_tfdeploy"]
  policy_arns = ["arn:aws:iam::aws:policy/tf-service_travis_tfdeploy_policy"]
}
