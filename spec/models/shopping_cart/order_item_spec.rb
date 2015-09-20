require 'spec_helper'

module ShoppingCart
  RSpec.describe OrderItem, type: :model do
    subject {FactoryGirl.create :order_item_with_book}
    it {expect(subject).to validate_presence_of(:price)}
    it {expect(subject).to validate_presence_of(:quantity)}
    it {expect(subject).to validate_numericality_of(:price)}
    it {expect(subject).to validate_numericality_of(:quantity)}
    it {expect(subject).to belong_to(:order)}
    it {expect(subject).to belong_to(:cartable)}
  end
end
