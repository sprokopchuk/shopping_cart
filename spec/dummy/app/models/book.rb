class Book < ActiveRecord::Base
  validates :title, :price, :in_stock, presence: true
  validates :price, :in_stock, numericality: true
  acts_as_cartable :title => "title", :price => "price", :thumb_image_url => "image.thumb.url", :in_stock => "in_stock"
  mount_uploader :image, ImageBookUploader

  def in_stock?
    self.in_stock > 0 ? true : false
  end

end


