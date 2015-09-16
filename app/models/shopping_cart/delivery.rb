module ShoppingCart
  class Delivery < ActiveRecord::Base
    validates :name, :price, presence: true
    has_many :orders
  end
end
