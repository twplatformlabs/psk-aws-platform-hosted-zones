require 'awspec'

describe route53_hosted_zone('sbx-i01-aws-us-east-1.twplatformlabs.org.') do
  it { should exist }
end

describe route53_hosted_zone('sbx-i01-aws-us-east-1.twplatformlabs.link.') do
  it { should exist }
end

describe route53_hosted_zone('preview.twplatformlabs.org.') do
  it { should exist }
end

describe route53_hosted_zone('preview.twplatformlabs.link.') do
  it { should exist }
end
