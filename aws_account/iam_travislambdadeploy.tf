# IAM User
resource "aws_iam_user" "service_travis_lambdadeploy" {
  name = "service_travis_lambdadeploy"
}

# IAM Policy - S3 Access
resource "aws_iam_policy" "service_travis_lambdadeploy_s3_policy" {
  name        = "tf-service_travis_lambda_s3_deploy_policy"
  description = "Travis CI Lambda Deployment Policy - Managed by Terraform"
  path        = "/"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:PutObject",
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:s3:::${var.bucket_parameters["lambda-deployment_bucket_name"]}/*"
      ]
    }
  ]
}
EOF
}

# IAM Policy - Lambda Access
resource "aws_iam_policy" "service_travis_lambdadeploy_lambda_policy" {
  name        = "tf-service_travis_lambdadeploy_lambda_policy"
  description = "Travis CI Lambda Deployment Policy - Managed by Terraform"
  path        = "/"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "lambda:UpdateFunctionCode",
        "lambda:PublishVersion",
        "lambda:UpdateAlias",
        "lambda:CreateFunction",
        "lambda:GetFunction",
        "iam:GetRole",
        "iam:PassRole"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

module "sliplab-tf-service_travis_lambdadeploy-group" {
  source     = "git::https://github.com/michalschott/tf-aws-iam-group.git?ref=master"
  name       = "sliplab-tf-service_travis_lambdadeploy-group"
  membership = ["service_travis_lambdadeploy"]

  policy_arns = ["arn:aws:iam::191779904557:policy/tf-service_travis_lambda_s3_deploy_policy",
    "arn:aws:iam::191779904557:policy/tf-service_travis_lambdadeploy_lambda_policy",
  ]
}
