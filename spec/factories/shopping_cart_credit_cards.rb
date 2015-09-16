require 'faker'
FactoryGirl.define do
  factory :credit_card, :class => ShoppingCart::CreditCard do
    number {Faker::Business.credit_card_number.delete "-"}
    cvv 456
    exp_month {Faker::Business.credit_card_expiry_date.month}
    exp_year {Faker::Business.credit_card_expiry_date.year}
    first_name {Faker::Name.name.split(" ")[0]}
    last_name {Faker::Name.name.split(" ")[1]}
    user_id 1
  end

end
