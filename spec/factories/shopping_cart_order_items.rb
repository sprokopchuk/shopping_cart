require 'faker'
FactoryGirl.define do
  factory :order_item, :class => ShoppingCart::OrderItem do
    price "100.5"
    quantity "1"
    product
    order
  end

end
