class Book < ActiveRecord::Base
  validates :title, :price, :in_stock, presence: true
  validates :price, :in_stock, numericality: true
  acts_as_cartable :name => "gool", :price => "price", :image => "image", :in_stock => "in_stock"

  def in_stock?
    self.in_stock > 0 ? true : false
  end

end


