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

# ===================================================== Deprecated
describe route53_hosted_zone('twdps.digital.') do
  it { should exist }
end

describe route53_hosted_zone('sbx-i01-aws-us-east-1.twdps.io.') do
  it { should exist }
end

describe route53_hosted_zone('sbx-i01-aws-us-east-1.twdps.digital.') do
  it { should exist }
end

describe route53_hosted_zone('preview.twdps.io.') do
  it { should exist }
end

describe route53_hosted_zone('preview.twdps.digital.') do
  it { should exist }
end
