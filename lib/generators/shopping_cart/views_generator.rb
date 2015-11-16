require 'rails/generators'
module ShoppingCart
  class ViewsGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def views
      directory 'cart', 'app/views/shopping_cart/cart'
      directory 'checkout', 'app/views/shopping_cart/checkout'
      directory 'orders', 'app/views/shopping_cart/orders'
      directory 'shared', 'app/views/shopping_cart/shared'
    end
  end
end
