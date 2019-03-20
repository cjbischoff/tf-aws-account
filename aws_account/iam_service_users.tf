
resource "aws_iam_user" "service_travis_tfdeploy" {
  name = "service_travis_tfdeploy"
}
resource "aws_iam_user" "service_travis_lambdadeploy" {
  name = "service_travis_lambdadeploy"
}