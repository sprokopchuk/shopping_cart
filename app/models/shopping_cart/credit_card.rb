module ShoppingCart
  class CreditCard < ActiveRecord::Base
    belongs_to :user, class_name: ShoppingCart.user_class.to_s
    has_many :orders
    validates :number, :cvv, :exp_month, :exp_year, :first_name, :last_name, presence: true
    validates :exp_month, inclusion: { in: 1..12 }
    validates :cvv, numericality: true
    validates :number, length: { is: 16 }
  end
end
