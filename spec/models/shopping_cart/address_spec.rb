require 'spec_helper'
module ShoppingCart
  describe Address, type: :model do
    let(:authenticated_user) {FactoryGirl.create :user}
    subject {FactoryGirl.create :address, user_id: authenticated_user.id}
    it {expect(subject).to validate_presence_of(:address)}
    it {expect(subject).to validate_presence_of(:zipcode)}
    it {expect(subject).to validate_presence_of(:city)}
    it {expect(subject).to validate_presence_of(:phone)}
    it {expect(subject).to validate_presence_of(:country_id)}
    it {expect(subject).to belong_to(:country)}
  end
end
