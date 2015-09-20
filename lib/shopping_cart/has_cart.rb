module ShoppingCart
  module HasCart
    def has_shopping_cart
      has_many :orders, dependent: :destroy, class_name: ShoppingCart::Order
      has_one :credit_card, class_name: ShoppingCart::CreditCard
      has_one :billing_address, -> { where(billing_address: true) }, class_name: "ShoppingCart::Address"
      has_one :shipping_address, -> { where(shipping_address: true) }, class_name: "ShoppingCart::Address"
    end
  end
end
