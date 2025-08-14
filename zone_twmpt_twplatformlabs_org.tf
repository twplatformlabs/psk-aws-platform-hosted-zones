# twmpt.twplatformlabs.org
# Short-term zone delegation to Googcle Cloud DNS for tail-mpt project:

# Create a zone delegation in the top level domain for this subdomain
module "subdomain_zone_delegation_twmpt_twplatformlabs_org" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "5.0.0"
  create  = true

  providers = {
    aws = aws.domain_twplatformlabs_org
  }

  private_zone = false
  zone_name = local.domain_twplatformlabs_org
  records = [
    {
      name            = "twmpt"
      type            = "NS"
      ttl             = 172800
      zone_id         = data.aws_route53_zone.zone_id_twplatformlabs_org.id
      allow_overwrite = true
      records         = [
        "ns-cloud-c1.googledomains.com.",
        "ns-cloud-c2.googledomains.com.",
        "ns-cloud-c3.googledomains.com.",
        "ns-cloud-c4.googledomains.com.",
      ]
    }
  
  # TODO: add when/if DNSSEC is activitated on the zone configuration in Google Cloud DNS
  # {
  #   name    = "twmpt"
  #   type    = "DS"
  #   ttl     = 86400
  #   zone_id = data.aws_route53_zone.zone_id_twplatformlabs_org.id
  #   records = [
  #     "2371 8 2 49FD46E6C4B45C55D4AC..."
  #   ]
  # }

  ]

  depends_on = [module.subdomain_api_twplatformlabs_org]
}


