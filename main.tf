provider "aws" {
  alias  = "top_level_domain"
  region = "us-east-2"
  assume_role {
    role_arn     = "arn:aws:iam::${var.prod_account_id}:role/${var.assume_role}"
  }
}

# zone id for the top-level-zone
data "aws_route53_zone" "top_level_zone" {
  provider = aws.top_level_domain
  name     = var.top_level_domain
}

module "iam_assumable_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 4.2"
  create_role = true

  role_name         = "dns-manager"
  trusted_role_arns = [
    "arn:aws:iam::${var.nonprod_account_id}:role/cert-manager",
    "arn:aws:iam::${var.prod_account_id}:role/cert-manager"
  ]

  custom_role_policy_arns = [
    aws_iam_policy.dns_manager.arn
  ]
  number_of_custom_role_policy_arns = 1
}

resource "aws_iam_policy" "dns_manager" {
  name   = "DNSManager"
  policy = data.aws_iam_policy_document.dns_manager.json
}

data "aws_iam_policy_document" "dns_manager" {
  # statement {
  #   effect = "Allow"
  #   principals {
  #     type        = "AWS"
  #     identifiers = [
  #       "arn:aws:iam::${var.nonprod_account_id}:role/cert-manager",
  #       "arn:aws:iam::${var.prod_account_id}:role/cert-manager"
  #     ]
  #   }
  #   actions = [
  #     "sts:AssumeRole"
  #   ]
  #   resources = ["*"]
  # }

  statement {
    effect = "Allow"

    actions = [
      "route53:GetChange"
    ]

    resources = ["arn:aws:route53:::change/*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "route53:ChangeResourceRecordSets",
      "route53:ListResourceRecordSets"
    ]

    resources = ["arn:aws:route53:::hostedzone/*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "route53:ListHostedZonesByName"
    ]

    resources = ["*"]
  }
}
