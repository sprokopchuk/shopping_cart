module ShoppingCart
  class OrderItem < ActiveRecord::Base
    belongs_to :order
    validates :price, :quantity, presence: true
    validates :price, numericality:  { greater_than_or_equal_to: 0.01 }
    validates :quantity, numericality:  { greater_than_or_equal_to: 0 }

    belongs_to :cartable, polymorphic: true
    after_create :add_cartable_methods

    def ==(other_order_item)
      self.cartable_id == other_order_item.cartable_id && self.cartable_type == other_order_item.cartable_type
    end

    def total_price
      self.price * self.quantity
    end

    def add_cartable_methods
      cartable_configuration.each do |k, v|
        self.class.send(:define_method, "cartable_#{k}") {self.cartable.instance_eval(v)}
      end
    end

    private

    def cartable_configuration
      self.cartable.class.instance_variable_get(:@cartable_configuration)
    end


  end
end
