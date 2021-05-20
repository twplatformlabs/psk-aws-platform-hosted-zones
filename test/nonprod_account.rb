# frozen_string_literal: true
require 'awspec'
require 'json'
require './test/test_values.rb'

# nonprod account subdomain tests
$subdomains.each do |subdomain|
  subdomain += $domain

  describe route53_hosted_zone(subdomain) do
    it { should exist }
    it { should have_record_set(subdomain).type('ns') }
    it { should have_record_set(subdomain).type('soa') }
  end
end
