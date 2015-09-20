require 'spec_helper'
FactoryGirl.define do
  factory :book do
    title {Faker::Lorem.sentence}
    description {Faker::Lorem.sentence}
    price 50
    in_stock 50
  end

end
