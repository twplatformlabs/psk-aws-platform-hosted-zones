# add additional subdomains here
$subdomains = []
$subdomains << 'sandbox.'
$subdomains << 'preview.'

# fetch top level domain from tfvars file
$domain = JSON.parse(File.read('./' + ENV['TEST_ENV'] + '.auto.tfvars.json'))["top_level_domain"] + '.'
