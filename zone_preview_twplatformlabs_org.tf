# *.preview.twplatformlabs.org

# define a provider in the account where this subdomain will be managed
provider "aws" {
  alias  = "subdomain_preview_twplatformlabs_org"
  region = "us-east-1"
  assume_role {
    role_arn     = "arn:aws:iam::${var.nonprod_account_id}:role/${var.assume_role}"
    session_name = "psk-aws-platform-hosted-zones"
  }
}

# create a route53 hosted zone for the subdomain in the account defined by the provider above
module "subdomain_preview_twplatformlabs_org" {
  source  = "terraform-aws-modules/route53/aws//modules/zones"
  version = "6.4.0"
  create  = true

  providers = {
    aws = aws.subdomain_preview_twplatformlabs_org
  }

  zones = {
    "preview.${local.domain_twplatformlabs_org}" = {
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
module "subdomain_zone_delegation_preview_twplatformlabs_org" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "6.4.0"
  create  = true

  providers = {
    aws = aws.domain_twplatformlabs_org
  }

  private_zone = false
  zone_name = local.domain_twplatformlabs_org
  records = [
    {
      name            = "preview"
      type            = "NS"
      ttl             = 172800
      zone_id         = data.aws_route53_zone.zone_id_twplatformlabs_org.id
      allow_overwrite = true
      records         = module.subdomain_preview_twplatformlabs_org.route53_zone_name_servers["preview.${local.domain_twplatformlabs_org}"]
    }
  ]

  depends_on = [module.subdomain_preview_twplatformlabs_org]
}
