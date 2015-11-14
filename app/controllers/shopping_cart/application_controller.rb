module ShoppingCart
  class ApplicationController < ::ApplicationController
    include Devise::Controllers::Helpers
    helper_method :cart_user, :current_cart

    def cart_user
      send(ShoppingCart.current_user_method)
    end

    def current_cart
      Order.find_or_create_current_cart(user: cart_user)
    end



   rescue_from CanCan::AccessDenied do |exception|
     redirect_to main_app.root_url, :alert => exception.message
   end
  end
end
