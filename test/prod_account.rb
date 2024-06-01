require 'awspec'

describe route53_hosted_zone('twdps.io.') do
  it { should exist }
end

describe route53_hosted_zone('dev.twdps.io.') do
  it { should exist }
end

describe route53_hosted_zone('dev.twdps.digital.') do
  it { should exist }
end

describe route53_hosted_zone('prod.twdps.io.') do
  it { should exist }
end

describe route53_hosted_zone('prod.twdps.digital.') do
  it { should exist }
end

describe route53_hosted_zone('prod-i01-aws-us-east-2.twdps.io.') do
  it { should exist }
end

describe route53_hosted_zone('prod-i01-aws-us-east-2.twdps.digital.') do
  it { should exist }
end

describe route53_hosted_zone('qa.twdps.io.') do
  it { should exist }
end

describe route53_hosted_zone('qa.twdps.digital.') do
  it { should exist }
end

