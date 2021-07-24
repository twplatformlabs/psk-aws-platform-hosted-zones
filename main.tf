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

resource "aws_iam_role" "dns_manager" {
  name = "dns_manager"
  provider = aws.top_level_domain
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = [
            "arn:aws:iam::${var.nonprod_account_id}:role/cert-manager",
            "arn:aws:iam::${var.prod_account_id}:role/cert-manager"
          ]
        }
      }
    ]
  })

  tags = {
    pipeline = "lab-platform-hosted-zones"
  }
}

resource "aws_iam_policy" "dns_manager_policy" {
  name = "dns_manager_policy"
  provider = aws.top_level_domain
  policy = data.aws_iam_policy_document.dns_manager.json
  tags = {
    pipeline = "lab-platform-hosted-zones"
  }
}

resource "aws_iam_policy_attachment" "attachment_dns_manager_policy_to_dns_manager" {
  name = "dns_manager_policy_attachment"
  provider = aws.top_level_domain
  roles = [aws_iam_role.dns_manager.name]
  policy_arn = aws_iam_policy.dns_manager_policy.arn
}

data "aws_iam_policy_document" "dns_manager" {

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
