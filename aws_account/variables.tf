variable "profile" {
  description = "AWS cli profile to be used for the SlipLab Account."
  default     = "sliplab"
}

variable "region" {
  default = "us-west-2"
}

variable "account_id" {
  description = "Account ID of the AWS account being managed."
  default     = "191779904557"
}

variable "environment" {
  description = "Environment"
  default     = "production"
}

variable "business_unit" {
  description = "Business Unit"
  default     = "sliplab"
}

variable tags {
  type = "map"

  default = {
    Name         = ""
    businessunit = "SlipLab"
    environment  = "production"
    application  = ""
    createdby    = "Terraform"
  }
}

variable "bucket_parameters" {
  description = "Bucket parameters for audit and global uses."
  type        = "map"

  default = {
    terraform_s3_bucket_name             = "io.sliplab.terraform.uw2"



  }
}
