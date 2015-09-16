require "shopping_cart/engine"

module ShoppingCart
  mattr_accessor :user_class, :current_cart, :product_class, :current_user

  def self.user_class
    if @@user_class.is_a?(Class)
      raise "ShoppingCart.user_class MUST be a String or Symbol object, not a Class object."
    elsif @@user_class.is_a?(String) || @@user_class.is_a?(Symbol)
      @@user_class.to_s.constantize
    end
  end

  def self.current_cart
    if @@current_cart.is_a?(Class)
      raise "ShoppingCart.current_class MUST be a String or Symbol object, not a Class object."
    end
  end

  def self.current_user
    if @@current_user.is_a?(Class)
      raise "ShoppingCart.current_user MUST be a String or Symbol object, not a Class object."
    end
  end

  def self.product_class
    if @@product_class.is_a?(Class)
      raise "ShoppingCart.product_class MUST be a String or Symbol object, not a Class object."
    elsif @@product_class.is_a?(String) || @@product_class.is_a?(Symbol)
      @@product_class.to_s.constantize
    end
  end
end
