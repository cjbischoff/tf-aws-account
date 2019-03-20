resource "aws_iam_saml_provider" "jumpcloud" {
  name                   = "jumpcloud"
  saml_metadata_document = "${data.aws_secretsmanager_secret_version.jumpcloud_idp.secret_string}"
}

#-----------------------------------------------
# AWS SM - Secrets Manager get values and set to variables
#-----------------------------------------------
data "aws_secretsmanager_secret_version" "jumpcloud_idp" {
  secret_id = "${var.sm-jumpcloud_idp}"
}

data "aws_secretsmanager_secret_version" "jumpcloud_external_id" {
  secret_id = "${var.sm-jumpcloud_external_id}"
}

#-----------------------------------------------
# AWS IAM - jumpcloud External Trust Role/Policy 
#-----------------------------------------------
resource "aws_iam_role" "jumpcloud_external_role" {
  name = "security-jumpcloud-access-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${var.jumpcloud_account_id}:root"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringEquals": {
          "sts:ExternalId": "${data.aws_secretsmanager_secret_version.jumpcloud_external_id.secret_string}"
        }
      }
    }
  ]
}
EOF
}

resource "aws_iam_policy" "jumpcloud_external_role" {
  name = "security-jumpcloud-access-role"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "iam:ListAccountAliases",
                "iam:ListRoles"
            ],
            "Effect": "Allow",
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "jumpcloud_external_role" {
  role       = "${aws_iam_role.jumpcloud_external_role.name}"
  policy_arn = "${aws_iam_policy.jumpcloud_external_role.arn}"
}

#-----------------------------------------------
# AWS IAM - jumpcloud Admin Role/Policy
#-----------------------------------------------
resource "aws_iam_role" "jumpcloud_admin_role" {
  name = "tf-jumpcloud_admin_role"

  max_session_duration = "28800" #8 hrs

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::${var.account_id}:saml-provider/jumpcloud"
      },
      "Action": "sts:AssumeRoleWithSAML",
      "Condition": {
        "StringEquals": {
          "SAML:aud": "https://signin.aws.amazon.com/saml"
        }
      }
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "jumpcloud_admin_attach" {
  role       = "${aws_iam_role.jumpcloud_admin_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

#-----------------------------------------------
# AWS IAM - jumpcloud ReadOnly & SecureityAudit Role/Policy
#-----------------------------------------------
resource "aws_iam_role" "jumpcloud_read_role" {
  name = "tf-jumpcloud_read_role"

  max_session_duration = "14400" # 4 hrs

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::${var.account_id}:saml-provider/jumpcloud"
      },
      "Action": "sts:AssumeRoleWithSAML",
      "Condition": {
        "StringEquals": {
          "SAML:aud": "https://signin.aws.amazon.com/saml"
        }
      }
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "jumpcloud_read_attach_ro" {
  role       = "${aws_iam_role.jumpcloud_read_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "jumpcloud_read_attach_sa" {
  role       = "${aws_iam_role.jumpcloud_read_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/SecurityAudit"
}

#-----------------------------------------------
# AWS IAM - jumpcloud Finance Admin Role/Policy
#-----------------------------------------------
resource "aws_iam_role" "jumpcloud_finance_admin_role" {
  name = "tf-jumpcloud_finance_admin_role"

  max_session_duration = "3600" # 1 hrs

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::${var.account_id}:saml-provider/jumpcloud"
      },
      "Action": "sts:AssumeRoleWithSAML",
      "Condition": {
        "StringEquals": {
          "SAML:aud": "https://signin.aws.amazon.com/saml"
        }
      }
    }
  ]
}
EOF
}

resource "aws_iam_policy" "jumpcloud_finance_admin_policy" {
  name = "tf-jumpcloud_finance_admin_policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "aws-portal:ViewAccount",
        "aws-portal:ViewBilling",
        "aws-portal:ViewBudget",
        "aws-portal:ViewPaymentMethods",
        "aws-portal:ViewUsage"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "jumpcloud_finance_admin_attach" {
  role       = "${aws_iam_role.jumpcloud_finance_admin_role.name}"
  policy_arn = "${aws_iam_policy.jumpcloud_finance_admin_policy.arn}"
}