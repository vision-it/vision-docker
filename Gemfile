source ENV['GEM_SOURCE'] || 'https://rubygems.org'

puppetversion = ENV.key?('PUPPET_VERSION') ? ENV['PUPPET_VERSION'] : ['5.3.7']
gem 'puppet', puppetversion

gem 'puppetlabs_spec_helper', '2.13.1'
gem 'rake', '12.3.2'
gem 'rspec-puppet', '2.7.3'

group :rubocop do
  gem 'rubocop', '0.65.0'
  gem 'rubocop-rspec', '1.32.0'
end

group :testing do
  gem 'metadata-json-lint', '1.2.2'
  gem 'rspec-puppet-facts', '1.8.0'
end

group :acceptance do
  gem 'rbnacl', '< 5.0', :require => false
  gem 'rbnacl-libsodium', :require => false
  gem 'bcrypt_pbkdf', '< 2.0', :require => false
  gem 'beaker', '4.6.0'
  gem 'beaker-docker', '0.5.2'
  gem 'beaker-rspec', '6.2.4'
  gem "beaker-puppet_install_helper", :require => false
  gem 'serverspec', '2.41.3'
  gem 'specinfra', '2.76.9'
end

group :development do
  gem 'travis',      :require => false
  gem 'travis-lint', :require => false
end
