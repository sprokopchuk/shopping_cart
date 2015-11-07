require "shopping_cart/engine"
require "shopping_cart/cartable"
require 'shopping_cart/has_cart'
ActiveRecord::Base.extend ShoppingCart::Cartable
ActiveRecord::Base.extend ShoppingCart::HasCart

module ShoppingCart
  mattr_accessor :user_class, :current_user_method

  def self.user_class
    @@user_class.constantize
  end

end
