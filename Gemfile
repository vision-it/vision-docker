source ENV['GEM_SOURCE'] || 'https://rubygems.org'

puppetversion = ENV.key?('PUPPET_VERSION') ? ENV['PUPPET_VERSION'] : ['4.6.1']
gem 'puppet', puppetversion

gem 'rake', '11.3.0'
gem 'rspec-puppet', '2.5.0'
gem 'puppetlabs_spec_helper', '1.2.2'

group :rubocop do
  gem 'rubocop', '0.47.0'
  gem 'rubocop-rspec', '1.10.0'
end

group :testing do
  gem 'metadata-json-lint', '1.1.0'
  gem 'rspec-puppet-facts', '1.7.1'
end

group :acceptance do
  gem 'beaker-rspec', '6.1.0'
  gem 'serverspec', '2.38.0'
  gem 'specinfra', '2.67.9'
  gem 'fog-core', '1.43.0' # https://github.com/fog/fog-core/issues/206
end

group :development do
  gem 'travis',           :require => false
  gem 'travis-lint',      :require => false
  gem 'rbnacl',           :require => false
  gem 'rbnacl-libsodium', :require => false
  gem 'bcrypt_pbkdf',     :require => false
end
