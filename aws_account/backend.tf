
    
terraform {
  backend "s3" {
    bucket         = "io.sliplab.terraform.uw2"
    key            = "aws_account/account"
    region         = "us-west-2"
    encrypt        = true
    dynamodb_table = "terraform.state.lock"
  }
}
