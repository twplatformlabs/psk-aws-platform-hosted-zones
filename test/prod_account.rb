# frozen_string_literal: true
require 'awspec'
require 'json'
require './test/test_values.rb'

describe route53_hosted_zone($domain) do
  it { should exist }
  it { should have_record_set($domain).type('ns') }
  it { should have_record_set($domain).type('soa') }
end

$subdomains.each do |subdomain|
  subdomain += $domain

  describe route53_hosted_zone($domain) do
    it { should exist }
    it { should have_record_set(subdomain).type('ns') }
  end
end
