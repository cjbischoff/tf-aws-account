output "jumpcloud_idp_arn" {
  value = "${aws_iam_saml_provider.jumpcloud.arn}"
}

output "jumpcloud_external_role_arn" {
  value = "${aws_iam_role.jumpcloud_external_role.arn}"
}

output "jumpcloud_admin_role_arn" {
  value = "${aws_iam_role.jumpcloud_admin_role.arn}"
}

output "jumpcloud_read_role_arn" {
  value = "${aws_iam_role.jumpcloud_read_role.arn}"
}

output "jumpcloud_finance_admin_role_arn" {
  value = "${aws_iam_role.jumpcloud_finance_admin_role.arn}"
}
