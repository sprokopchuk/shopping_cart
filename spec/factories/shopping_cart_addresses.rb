require 'faker'
FactoryGirl.define do
  factory :address, :class => ShoppingCart::Address do
    address {Faker::Address.street_address}
    zipcode {Faker::Address.zip_code}
    city {Faker::Address.city}
    phone {Faker::PhoneNumber.cell_phone}
    country
    user
    factory :billing_address do
      billing_address true
    end

    factory :shipping_address do
      shipping_address true
    end
  end
end
