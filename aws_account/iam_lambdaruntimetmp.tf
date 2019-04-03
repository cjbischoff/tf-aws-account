// Lambda IAM role
resource "aws_iam_role" "tf-lambda_basic_execution-role" {
  name        = "tf-lambda_basic_execution-role"
  path        = "/"
  description = "Temp Role for Lambda Deployment - Managed by Terraform"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "lambda.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_policy" "tf-lambda_xray_cloudwatch_access-policy" {
  name        = "tf-lambda_xray_cloudwatch_access-policy"
  description = "Xray and CloudWatch Access Policy for Lambda - Managed by Terraform"

  policy = <<EOF
{
"Version": "2012-10-17",
"Statement": [
  {
    "Action": [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "xray:PutTraceSegments",
      "xray:PutTelemetryRecords"
    ],
    "Effect": "Allow",
    "Resource": "*"
  }
]
}
EOF
}

resource "aws_iam_policy_attachment" "tf-lambda_basic_execution-attach" {
  name       = "tf-lambda_basic_execution-attach"
  roles      = ["${aws_iam_role.tf-lambda_basic_execution-role.name}"]
  policy_arn = "${aws_iam_policy.tf-lambda_xray_cloudwatch_access-policy.arn}"
}
