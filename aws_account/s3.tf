resource "aws_s3_bucket" "terraform-state" {
  bucket = "${var.bucket_parameters["terraform_s3_bucket_name"]}"

  force_destroy = "false"

  versioning {
    enabled = true


  }

  lifecycle {
    prevent_destroy = true
  }

  tags = "${merge(var.tags, map(
    "Name", "AWS-SlipLab Remote Terraform State Store",
    "application", "terraform"
  ))}"
}
