$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "shopping_cart/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "shopping_cart"
  s.version     = ShoppingCart::VERSION
  s.authors     = ["George Zhukov"]
  s.email       = ["scofield.cross@gmail.com"]
  s.homepage    = "https://github.com/GeorgeZhukov/shopping_cart"
  s.summary     = "Flexible shopping cart solution for Rails"
  s.description = "Flexible shopping cart solution for Rails"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.2.4"

  s.add_dependency 'country_select'
  s.add_dependency 'credit_card_validations'
  s.add_dependency 'geocoder'
  s.add_dependency 'state_machines-activerecord'
  s.add_dependency "wicked"
  s.add_dependency "haml-rails", "~> 0.9"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency 'rspec-rails', '~> 3.0'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency "codeclimate-test-reporter"
  s.add_development_dependency "shoulda-matchers"
  s.add_development_dependency "faker"
  s.add_development_dependency "devise"
end
