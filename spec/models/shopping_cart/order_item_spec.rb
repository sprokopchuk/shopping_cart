require 'spec_helper'

module ShoppingCart
  RSpec.describe OrderItem, type: :model do
    subject {FactoryGirl.create :order_item, product_id: 1}
    it {expect(subject).to validate_presence_of(:price)}
    it {expect(subject).to validate_presence_of(:quantity)}
    it {expect(subject).to validate_numericality_of(:price)}
    it {expect(subject).to validate_numericality_of(:quantity)}
    it {expect(subject).to belong_to(:order)}
    it {expect(subject).to belong_to(:product)}
  end
end
