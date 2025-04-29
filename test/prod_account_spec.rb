require 'awspec'

describe route53_hosted_zone('twplatformlabs.org.') do
  it { should exist }
end

describe route53_hosted_zone('twplatformlabs.link.') do
  it { should exist }
end

describe route53_hosted_zone('prod-i01-aws-us-east-2.twplatformlabs.org.') do
  it { should exist }
end

describe route53_hosted_zone('prod-i01-aws-us-east-2.twplatformlabs.link.') do
  it { should exist }
end

describe route53_hosted_zone('dev.twplatformlabs.org.') do
  it { should exist }
end

describe route53_hosted_zone('dev.twplatformlabs.link.') do
  it { should exist }
end

describe route53_hosted_zone('qa.twplatformlabs.org.') do
  it { should exist }
end

describe route53_hosted_zone('qa.twplatformlabs.link.') do
  it { should exist }
end

describe route53_hosted_zone('api.twplatformlabs.org.') do
  it { should exist }
end

describe route53_hosted_zone('api.twplatformlabs.link.') do
  it { should exist }
end
