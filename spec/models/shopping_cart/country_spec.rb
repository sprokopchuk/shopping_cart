require 'spec_helper'
module ShoppingCart
  describe Country, type: :model do
    subject {FactoryGirl.create :country }
    it {expect(subject).to validate_presence_of(:name)}
    it {expect(subject).to validate_uniqueness_of(:name)}
    it {expect(subject).to have_many(:addresses)}
  end
end
