module ShoppingCart
  class OrderItem < ActiveRecord::Base
    belongs_to :product, :class_name => ShoppingCart.product_class.to_s
    belongs_to :order
    validates :price, :quantity, :order_id, :product_id, presence: true
    validates :price, :quantity, numericality: true

    def ==(other_order_item)
      self.product_id == other_order_item.product_id
    end

    def total_price
      self.price * self.quantity
    end
  end
end
