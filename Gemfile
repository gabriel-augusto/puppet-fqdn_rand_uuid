source :rubygems

group :development, :unit_tests do
  gem 'puppetlabs_spec_helper', :require => false
  gem 'rspec-puppet', :require => false
end

if ENV['PUPPET_GEM_VERSION']
  gem 'puppet', ENV['PUPPET_GEM_VERSION'], :require => false
else
  gem 'puppet', :require => false
end
