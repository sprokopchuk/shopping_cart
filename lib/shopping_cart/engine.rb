require 'devise'
require 'sass-rails'
require 'bootstrap-sass'

module ShoppingCart
  class Engine < ::Rails::Engine
    isolate_namespace ShoppingCart
    config.generators do |g|
      g.test_framework      :rspec,        :fixture => false
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
      g.helper false
    end

    config.to_prepare do
      ActionController::Base.send(:include, ShoppingCart::CartHelper)
    end
  end
end
