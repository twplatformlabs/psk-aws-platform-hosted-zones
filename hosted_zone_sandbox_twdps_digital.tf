provider "aws" {
  alias  = "subdomain_sandbox_twdps_digital"
  region = "us-east-2"
  assume_role {
    role_arn     = "arn:aws:iam::${var.nonprod_account_id}:role/${var.assume_role}"
    session_name = "lab-platform-hosted-zones"
  }
}

module "subdomain_sandbox_twdps_digital" {
  source  = "terraform-aws-modules/route53/aws//modules/zones"
  version = "2.0.0"
  create  = true

  providers = {
    aws = aws.subdomain_sandbox_twdps_digital
  }

  zones = {
    "sandbox.${local.domain_twdps_digital}" = {
      tags = {
        cluster = "sandbox"
      }
    }
  }

  tags = {
    pipeline = "lab-platform-hosted-zones"
  }
}

module "subdomain_zone_delegation_sandbox_twdps_digital" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "2.0.0"
  create  = true

  providers = {
    aws = aws.domain_twdps_digital
  }

  private_zone = false
  zone_name = local.domain_twdps_digital
  records = [
    {
      name            = "sandbox"
      type            = "NS"
      ttl             = 172800
      zone_id         = data.aws_route53_zone.zone_id_twdps_digital.id
      allow_overwrite = true
      records         = lookup(module.subdomain_sandbox_twdps_digital.route53_zone_name_servers,"sandbox.${local.domain_twdps_digital}")
    }
  ]

  depends_on = [module.subdomain_sandbox_twdps_digital]
}
