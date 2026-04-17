# *.prod-i01-aws-us-east-2.twplatformlabs.link

moved {
  from = module.subdomain_prod_i01_aws_us_east_2_twplatformlabs_link.aws_route53_zone.this["prod-i01-aws-us-east-2.twplatformlabs.link"]
  to   = module.subdomain_prod_i01_aws_us_east_2_twplatformlabs_link.aws_route53_zone.this[0]
}
moved {
  from = module.subdomain_zone_delegation_prod_i01_aws_us_east_2_twplatformlabs_link.aws_route53_record.this["prod-i01-aws-us-east-2 NS"]
  to   = module.subdomain_zone_delegation_prod_i01_aws_us_east_2_twplatformlabs_link.aws_route53_record.this["prod-i01-aws-us-east-2"]
}
# define a provider in the account where this subdomain will be managed
provider "aws" {
  alias  = "subdomain_prod_i01_aws_us_east_2_twplatformlabs_link"
  region = "us-east-2"
  assume_role {
    role_arn     = "arn:aws:iam::${var.prod_account_id}:role/${var.assume_role}"
    session_name = "psk-aws-platform-hosted-zones"
  }
}

# create a route53 hosted zone for the subdomain in the account defined by the provider above
module "subdomain_prod_i01_aws_us_east_2_twplatformlabs_link" {
  source  = "terraform-aws-modules/route53/aws"
  version = "6.4.0"

  providers = {
    aws = aws.subdomain_prod_i01_aws_us_east_2_twplatformlabs_link
  }

  name = "prod-i01-aws-us-east-2.${local.domain_twplatformlabs_link}"

  tags = {
    cluster = "prod-i01-aws-us-east-2"
    pipeline = "psk-aws-platform-hosted-zones"
  }
}

# Create a zone delegation in the top level domain for this subdomain
module "subdomain_zone_delegation_prod_i01_aws_us_east_2_twplatformlabs_link" {
  source  = "terraform-aws-modules/route53/aws"
  version = "6.4.0"

  providers = {
    aws = aws.domain_twplatformlabs_link
  }

  create_zone = false
  name = local.domain_twplatformlabs_link
  records = {
    prod-i01-aws-us-east-2 = {
      type            = "NS"
      ttl             = 172800
      allow_overwrite = true
      records         = module.subdomain_prod_i01_aws_us_east_2_twplatformlabs_link.name_servers
    }
  }

  depends_on = [module.subdomain_prod_i01_aws_us_east_2_twplatformlabs_link]
}
