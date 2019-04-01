// Lambda IAM role
resource "aws_iam_role" "tf-lambda_basic_execution-role" {
  name = "tf-lambda_basic_execution-role"
  path = "/"

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
  description = "Xray and CloudWatch Access for Lambda - Managed by Terraform"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "xray:PutTraceSegments",
        "xray:PutTelemetryRecords"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF

  policy = <<EOF
{
"Version": "2012-10-17",
"Statement": [
  {
    "Action": [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ],
    "Effect": "Allow",
    "Resource": "*"
  }
]
}
EOF
}

resource "aws_iam_policy" "tf-lambda_cloudwatch_upload-policy" {
  name        = "tf-lambda_cloudwatch_upload-policy"
  description = "CloudWatch Access - Managed by Terraform"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
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
