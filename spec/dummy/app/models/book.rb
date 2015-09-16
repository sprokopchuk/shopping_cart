class Book < ActiveRecord::Base
  validates :title, :price, :in_stock, presence: true
  validates :price, :in_stock, numericality: true
  belongs_to :product, polymorphic: true
  def in_stock?
    self.in_stock > 0 ? true : false
  end

end


