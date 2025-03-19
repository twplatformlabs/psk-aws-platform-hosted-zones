# *.preview.twplatformlabs.org

# define a provider in the account where this subdomain will be managed
provider "aws" {
  alias  = "subdomain_preview_twplatformlabs_link"
  region = "us-east-1"
  assume_role {
    role_arn     = "arn:aws:iam::${var.nonprod_account_id}:role/${var.assume_role}"
    session_name = "psk-aws-platform-hosted-zones"
  }
}

# create a route53 hosted zone for the subdomain in the account defined by the provider above
module "subdomain_preview_twplatformlabs_link" {
  source  = "terraform-aws-modules/route53/aws//modules/zones"
  version = "5.0.0"
  create  = true

  providers = {
    aws = aws.subdomain_preview_twplatformlabs_link
  }

  zones = {
    "preview.${local.domain_twplatformlabs_link}" = {
      tags = {
        cluster = "sbx-i01-aws-us-east-1"
      }
    }
  }

  tags = {
    pipeline = "psk-aws-platform-hosted-zones"
  }
}

# Create a zone delegation in the top level domain for this subdomain
module "subdomain_zone_delegation_preview_twplatformlabs_link" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "5.0.0"
  create  = true

  providers = {
    aws = aws.domain_twplatformlabs_link
  }

  private_zone = false
  zone_name = local.domain_twplatformlabs_link
  records = [
    {
      name            = "preview"
      type            = "NS"
      ttl             = 172800
      zone_id         = data.aws_route53_zone.zone_id_twplatformlabs_link.id
      allow_overwrite = true
      records         = module.subdomain_preview_twplatformlabs_link.route53_zone_name_servers["preview.${local.domain_twplatformlabs_link}"]
    }
  ]

  depends_on = [module.subdomain_preview_twplatformlabs_link]
}
