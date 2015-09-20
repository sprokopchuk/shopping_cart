class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name, presence: true
  has_shopping_cart


  def full_name
    first_name + " " + last_name unless first_name.nil?
  end

end
