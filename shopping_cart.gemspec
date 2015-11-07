$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "shopping_cart/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "shopping_cart"
  s.version     = ShoppingCart::VERSION
  s.authors     = ["Sergey Prokopchuk"]
  s.email       = ["prokopchuksv21@gmail.com"]
  s.homepage    = "http://github.com/sprokopchuk"
  s.summary     = "ShoppingCart"
  s.description = "ShoppingCart with checkout form"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.2.1"
  s.add_dependency "aasm"
  s.add_dependency "pg"
  s.add_dependency "devise"
  s.add_dependency 'virtus'
  s.add_dependency 'cancancan'
  s.add_dependency 'haml-rails'
  s.add_dependency 'carrierwave'
  s.add_dependency 'mini_magick'
  s.add_dependency 'fog'
  s.add_development_dependency 'rspec-activemodel-mocks'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'shoulda-matchers'
  s.add_development_dependency 'rspec-collection_matchers'
  s.add_development_dependency 'faker'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'factory_girl_rails'
end

