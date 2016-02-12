source "https://rubygems.org"

group :test do
  gem "rake"
  gem "puppet", ENV['PUPPET_VERSION'] || '~> 3.8.5'
  gem "rspec-puppet", '~> 2.3.2'
  gem "puppetlabs_spec_helper"
  gem "metadata-json-lint"
end

group :development do
  gem "travis"
  gem "travis-lint"
  gem "beaker"
  gem "beaker-rspec"
  gem "vagrant-wrapper"
  gem "puppet-blacksmith"
  gem "guard-rake"
  gem 'nokogiri', '= 1.6.7.1' # this version constraint should be removed, but currently Nokogiri 1.6.7.2 won't compile no OSX El Capitan
end
