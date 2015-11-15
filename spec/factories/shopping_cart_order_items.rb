require 'faker'
FactoryGirl.define do
  factory :order_item, :class => ShoppingCart::OrderItem do
    price 100.1
    quantity 1
    factory :order_item_with_book do
      association :cartable, factory: :book
    end
    order
  end

end
