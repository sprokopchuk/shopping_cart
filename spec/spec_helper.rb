ENV['RAILS_ENV'] ||= 'test'

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require 'rspec/rails'
require 'factory_girl_rails'
require 'shoulda/matchers'
require 'database_cleaner'
require 'faker'
require "rspec-activemodel-mocks"
require 'haml-rails'
require 'cancancan'
Rails.backtrace_cleaner.remove_silencers!
def main_app
  Rails.application.routes.url_helpers
end
# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.include Capybara::DSL
  config.mock_with :rspec
  config.use_transactional_fixtures = false
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
  config.include Shoulda::Matchers::ActiveRecord, type: :model
  config.include Warden::Test::Helpers
  config.include Devise::TestHelpers, :type => :controller
  config.expect_with :rspec do |expectations|
     expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.include AddressHelper
  config.include CheckoutHelper
  config.include ShoppingCart::Engine.routes.url_helpers

  config.before(:suite) do
    Warden.test_mode!
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end


  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
    Warden.test_reset!
  end
end
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec

    with.library :rails
  end
end
