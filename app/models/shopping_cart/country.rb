module ShoppingCart
  class Country < ActiveRecord::Base
    has_many :addresses
    validates :name, presence: true, uniqueness: true
  end
end
