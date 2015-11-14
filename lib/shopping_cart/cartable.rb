module ShoppingCart
  module Cartable
    mattr_accessor :cartables do
      []
    end

    def acts_as_cartable(options = {})
      configuration = { :title => "title", :price => "price", :thumb_image_url => "image.thumb.url", :in_stock => "in_stock" }
      configuration.update(options) if options.is_a?(Hash)
      @@cartables << self.to_s
      @cartable_configuration = configuration
      has_many :order_items, :as => :cartable, :class_name => ShoppingCart::OrderItem
    end

    def self.cartables
      @@cartables
    end

  end
end
