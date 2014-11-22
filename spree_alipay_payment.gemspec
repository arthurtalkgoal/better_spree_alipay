# coding: utf-8
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'spree_alipay_payment/version'

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_alipay_payment'
  s.version     = SpreeAlipayPayment::VERSION
  s.summary     = 'Adds Alipay Payment as a Payment Method to Spree Commerce'
  s.description = s.summary
  s.required_ruby_version = '>= 1.9.3'

  s.author       = 'Arthur CHAN'
  s.email        = 'arthur@talkgoal.com'
  s.homepage     = 'http://www.talkgoal.com'
  s.license      = %q{BSD-3}

  s.files        = `git ls-files`.split("\n")
  s.test_files   = `git ls-files -- spec/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '>= 2.4.0.rc3'
  s.add_dependency 'alipay', "0.1.0"

  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'capybara', '~> 2.1'
  s.add_development_dependency 'factory_girl', '~> 4.2'
  
  s.add_development_dependency("rspec", ">= 2.5.0")
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'sass-rails', '~> 4.0.2'
  s.add_development_dependency 'database_cleaner', '1.0.1'
  s.add_development_dependency 'pry'
end