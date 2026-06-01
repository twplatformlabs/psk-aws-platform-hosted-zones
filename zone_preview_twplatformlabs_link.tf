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

# route53 hosted zone for the subdomain in the account defined by the provider above
module "subdomain_preview_twplatformlabs_link" {
  source  = "terraform-aws-modules/route53/aws"
  version = "6.6.1"

  providers = {
    aws = aws.subdomain_preview_twplatformlabs_link
  }

  name = "preview.${local.domain_twplatformlabs_link}"

  tags = {
    cluster = "sbx-i01-aws-us-east-1"
    pipeline = "psk-aws-platform-hosted-zones"
  }
}

# Create a zone delegation in the top level domain for this subdomain
module "subdomain_zone_delegation_preview_twplatformlabs_link" {
  source  = "terraform-aws-modules/route53/aws"
  version = "6.6.1"

  providers = {
    aws = aws.domain_twplatformlabs_link
  }

  create_zone = false
  name = local.domain_twplatformlabs_link

  records = {
    preview = {
      name            = "preview"
      type            = "NS"
      ttl             = 172800
      allow_overwrite = true
      records         = module.subdomain_preview_twplatformlabs_link.name_servers
    }
  }

  depends_on = [module.subdomain_preview_twplatformlabs_link]
}
