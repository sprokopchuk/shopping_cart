module ShoppingCart
  module Cartable
    def acts_as_cartable(options = {})
      configuration = { :name => "title", :price => "price", :image => "image", :in_stock => "in_stock" }
      configuration.update(options) if options.is_a?(Hash)
      @cartable_configuration = configuration
      has_many :order_items, :as => :cartable, :class => ShoppingCart::OrderItem
    end
  end
end
