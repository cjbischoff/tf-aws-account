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

resource "aws_iam_user_policy_attachment" "service_travis_tfdeploy" {
  user       = "${aws_iam_user.service_travis_tfdeploy.name}"
  policy_arn = "${aws_iam_policy.service_travis_tfdeploy.arn}"
}
