# define a provider for the managing account of the subdomain
provider "aws" {
  alias  = "preview_account"
  region = "us-east-2"
  assume_role {
    role_arn     = "arn:aws:iam::${var.nonprod_account_id}:role/${var.assume_role}"
    session_name = "lab-platform-hosted-zones"
  }
}

#create the subdomain
module "preview_subdomain" {
  source  = "terraform-aws-modules/route53/aws//modules/zones"
  version = "2.0.0"

  providers = {
    aws = aws.preview_account
  }

  zones = {
    "preview.${var.top_level_domain}" = {
      comment = "subdomain hosted zone for dps lab preview cluster"
    }
  }

  tags = {
    cluster        = "preview"
    pipeline       = "lab-platform-hosted-zones"
  }
}

module "preview_zone_delegation" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 2.0"

  providers = {
    aws = aws.top_level_domain
  }

  zone_name = var.top_level_domain
  records = [
    {
      name            = "preview"
      type            = "NS"
      ttl             = 172800
      zone_id         = data.aws_route53_zone.top_level_zone.id
      allow_overwrite = true
      records         = lookup(module.preview_subdomain.route53_zone_name_servers,"preview.${var.top_level_domain}")
    }
  ]

  depends_on = [module.preview_subdomain]
}
