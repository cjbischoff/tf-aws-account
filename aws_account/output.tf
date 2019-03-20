# S3 - lambda-deployment id
output "s3_bucket_lambda-deployment_id" {
  value = "${aws_s3_bucket.lambda-deployment.id}"
}

# S3 - lambda-deployment arn
output "s3_bucket_lambda-deploymen_arn" {
  value = "${aws_s3_bucket.lambda-deployment.arn}"
}
