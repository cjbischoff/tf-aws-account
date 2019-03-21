resource "aws_iam_policy" "service_travis_lambdadeploy_s3_policy" {
  name = "tf-service_travis_lambda_s3_deploy_policy"
  path = "/"

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

resource "aws_iam_policy" "service_travis_lambdadeploy_lambda_policy" {
  name = "tf-service_travis_lambdadeploy_lambda_policy"
  path = "/"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "lambda:UpdateFunctionCode",
        "lambda:PublishVersion",
        "lambda:UpdateAlias"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
