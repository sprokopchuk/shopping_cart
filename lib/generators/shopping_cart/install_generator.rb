require 'rails/generators'
module ShoppingCart
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)
    def install
      route("mount ShoppingCart::Engine => '/'")
      template 'initializer.erb', 'config/initializers/shopping_cart.rb'
      rake 'shopping_cart:install:migrations'
    end
  end
end
