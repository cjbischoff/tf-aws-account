resource "aws_secretsmanager_secret" "jumpcloud_idp" {
  name                    = "jumpcloud_idp"
  description             = "This value is used for JumpCloud IDP metadata."
  recovery_window_in_days = "30"

  tags = "${merge(var.tags, map(
    "environment", "production",
    "application", "jumpcloud"
    ))}"
}
resource "aws_secretsmanager_secret" "jumpcloud_external_id" {
  name                    = "jumpcloud_external_id"
  description             = "This value is used for JumpCloud external ID."
  recovery_window_in_days = "30"

  tags = "${merge(var.tags, map(
    "environment", "production",
    "application", "jumpcloud"
    ))}"
}