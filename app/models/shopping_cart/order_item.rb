module ShoppingCart
  class OrderItem < ActiveRecord::Base
    #belongs_to :product, :class_name => ShoppingCart.product_class.to_s
    belongs_to :cartable, polymorphic: true
    belongs_to :order
    validates :price, :quantity, presence: true
    validates :price, :quantity, numericality: true

    def ==(other_order_item)
      self.cartable_id == other_order_item.cartable_id && self.cartable_type == other_order_item.cartable_type
    end

    def total_price
      self.price * self.quantity
    end
  end
end
