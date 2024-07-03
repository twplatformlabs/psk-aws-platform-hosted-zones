require 'awspec'

describe route53_hosted_zone('twdps.io.') do
  it { should exist }
end

describe route53_hosted_zone('prod-i01-aws-us-east-2.twdps.io.') do
  it { should exist }
end

describe route53_hosted_zone('prod-i01-aws-us-east-2.twdps.digital.') do
  it { should exist }
end
