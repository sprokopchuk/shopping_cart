require 'faker'
FactoryGirl.define do
  factory :delivery, :class => ShoppingCart::Delivery do
    name {Faker::Lorem.sentence}
    price 15
  end

end
