require 'spec_helper'

module ShoppingCart
  RSpec.describe OrderItem, type: :model do
    let(:book) {FactoryGirl.create :book}
    subject {FactoryGirl.create :order_item_with_book, cartable: book}
    it {expect(subject).to validate_numericality_of(:price).is_greater_than_or_equal_to(0.01)}
    it {expect(subject).to validate_numericality_of(:quantity).is_greater_than_or_equal_to(0)}
    it {expect(subject).to validate_presence_of(:price)}
    it {expect(subject).to validate_presence_of(:quantity)}
    it {expect(subject).to belong_to(:order)}
    it {expect(subject).to belong_to(:cartable)}

  end
end
