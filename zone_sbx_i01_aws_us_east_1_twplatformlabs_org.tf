# *.sbx-i01-aws-us-east-1.twplatformlabs.org

# define a provider in the account where this subdomain will be managed
provider "aws" {
  alias  = "subdomain_sbx_i01_aws_us_east_1_twplatformlabs_org"
  region = "us-east-1"
  assume_role {
    role_arn     = "arn:aws:iam::${var.nonprod_account_id}:role/${var.assume_role}"
    session_name = "psk-aws-platform-hosted-zones"
  }
}

# create a route53 hosted zone for the subdomain in the account defined by the provider above
module "subdomain_sbx_i01_aws_us_east_1_twplatformlabs_org" {
  source  = "terraform-aws-modules/route53/aws"
  version = "6.5.0"

  providers = {
    aws = aws.subdomain_sbx_i01_aws_us_east_1_twplatformlabs_org
  }

  name = "sbx-i01-aws-us-east-1.${local.domain_twplatformlabs_org}"

  tags = {
    cluster = "sbx-i01-aws-us-east-1"
    pipeline = "psk-aws-platform-hosted-zones"
  }
}

# Create a zone delegation in the top level domain for this subdomain
module "subdomain_zone_delegation_sbx_i01_aws_us_east_1_twplatformlabs_org" {
  source  = "terraform-aws-modules/route53/aws"
  version = "6.5.0"

  providers = {
    aws = aws.domain_twplatformlabs_org
  }

  create_zone = false
  name = local.domain_twplatformlabs_org
  records = {
    sbx-i01-aws-us-east-1 = {
      type            = "NS"
      ttl             = 172800
      allow_overwrite = true
      records         = module.subdomain_sbx_i01_aws_us_east_1_twplatformlabs_org.name_servers
    }
  }

  depends_on = [module.subdomain_sbx_i01_aws_us_east_1_twplatformlabs_org]
}
