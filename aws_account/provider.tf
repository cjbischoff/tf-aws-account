provider "aws" {
  region  = "${var.region}"
  profile = "${var.profile}"

  version = "~> 1.29.0"
}

terraform {
  required_version = " >=0.11"
}
