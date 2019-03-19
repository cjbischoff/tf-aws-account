resource "aws_dynamodb_table" "terraform-state-lock" {
  name           = "terraform.state.lock"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  tags {
    Name         = "DynamoDB Terraform State Lock Table"
    businessunit = "SlipLab"
    environment  = "production"
    application  = "terraform"
    createdby    = "Terraform"
  }
}
