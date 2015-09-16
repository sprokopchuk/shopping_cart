module ShoppingCart
  class ApplicationController < ActionController::Base
    helper_method :current_cart
    helper_method :current_user

    def current_cart
      @current_cart = current_user.send(ShoppingCart.current_cart)
    end

    def current_user
      @current_user = send(ShoppingCart.current_user)
    end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_url, :alert => exception.message
  end
  end
end
