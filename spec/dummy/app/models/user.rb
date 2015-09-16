class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :orders, dependent: :destroy, class_name: "ShoppingCart::Order"
  has_many :ratings
  has_one :credit_card, class_name: "ShoppingCart::CreditCard"
  has_one :wish_list
  has_one :billing_address, -> { where(billing_address: true) }, class_name: "ShoppingCart::Address"
  has_one :shipping_address, -> { where(shipping_address: true) }, class_name: "ShoppingCart::Address"
  validates :first_name, :last_name, presence: true
  accepts_nested_attributes_for :billing_address, :reject_if => :all_blank
  accepts_nested_attributes_for :shipping_address, :reject_if => :all_blank

  def current_order_in_progress
    current_order = self.orders.in_progress.take
    current_order.nil? ? self.orders.create : current_order
  end

  def full_name
    first_name + " " + last_name unless first_name.nil?
  end

end
