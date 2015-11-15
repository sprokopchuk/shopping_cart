module ShoppingCart
  module CartHelper
    def cart_user
      send(ShoppingCart.current_user_method)
    end

    def current_cart
      ShoppingCart::Order.find_or_create_current_cart(user: cart_user)
    end
  end
end
