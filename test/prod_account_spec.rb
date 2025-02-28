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

# ===================================================== Deprecated
describe route53_hosted_zone('twdps.io.') do
  it { should exist }
end

describe route53_hosted_zone('prod-i01-aws-us-east-2.twdps.io.') do
  it { should exist }
end

describe route53_hosted_zone('prod-i01-aws-us-east-2.twdps.digital.') do
  it { should exist }
end

describe route53_hosted_zone('dev.twdps.io.') do
  it { should exist }
end

describe route53_hosted_zone('dev.twdps.digital.') do
  it { should exist }
end

describe route53_hosted_zone('qa.twdps.io.') do
  it { should exist }
end

describe route53_hosted_zone('qa.twdps.digital.') do
  it { should exist }
end

describe route53_hosted_zone('api.twdps.io.') do
  it { should exist }
end

describe route53_hosted_zone('api.twdps.digital.') do
  it { should exist }
end
