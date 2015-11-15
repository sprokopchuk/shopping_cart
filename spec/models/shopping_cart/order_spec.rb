require 'spec_helper'
module ShoppingCart
  RSpec.describe Order, type: :model do
    subject {FactoryGirl.create :order}
    it {expect(subject).to validate_presence_of(:total_price)}
    it {expect(subject).to validate_presence_of(:state)}
    it {expect(subject).to validate_numericality_of(:total_price).is_greater_than_or_equal_to(0.01)}
    it {expect(subject).to belong_to(:user)}
    it {expect(subject).to belong_to(:credit_card)}
    it {expect(subject).to have_many(:order_items)}

    context ".in_progress" do
      let(:orders_in_progress) {FactoryGirl.create_list(:order, 3)}
      let(:orders_delivered) {FactoryGirl.create_list(:order_delivered, 3)}
      it "returns list of orders in state in progress" do
        expect(Order.in_progress).to match_array(orders_in_progress)
      end
      it "doesn't return list of orders in state shipped" do
        expect(Order.in_progress).not_to match_array(orders_delivered)
      end
    end

    context "#add" do
      let(:book) {FactoryGirl.create :book}
      let(:other_book) {FactoryGirl.create :book}
      it "add product when other product is already ordered" do
        subject.add book
        expect{subject.add other_book}.to change{subject.order_items.count}.by(1)
      end
      it "add product when it is not yet ordered" do
        expect{subject.add book}.to change{subject.order_items.count}.by(1)
      end
    end

    context "#real_price" do
      let(:book) {FactoryGirl.create :book}

      it "calculate to price for order when add one product" do
        subject.add book
        expect(subject.real_price).to eq(50)
      end
      it "change #total_price" do
        subject.add book
        expect{subject.real_price}.to change{subject.total_price}.from(100.1).to(50)
      end
    end
  end
end
