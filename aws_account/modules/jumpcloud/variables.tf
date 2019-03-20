variable "account_id" {}

variable "jumpcloud _account_id" {
  default = "842984801698"
}

variable "sm-jumpcloud_idp" {
  description = "Metadata queried from Secrets Manager for the JumpCloud IDP."
}

variable "sm-jumpcloud_external_id" {
  description = "External ID queried from Secrets Manager for the JumpCloud IAM trust."
  default     = ""
}