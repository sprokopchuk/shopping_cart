module ShoppingCart
  class ApplicationController < ::ApplicationController
    include Devise::Controllers::Helpers
    include ShoppingCart::CartHelper
    helper_method :current_cart, :cart_user
  end
end
