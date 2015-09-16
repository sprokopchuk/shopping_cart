require 'spec_helper'
module ShoppingCart
  RSpec.describe Order, type: :model do
    subject {FactoryGirl.create :order}
    it {expect(subject).to validate_presence_of(:total_price)}
    it {expect(subject).to validate_presence_of(:state)}
    it {expect(subject).to validate_numericality_of(:total_price)}
    it {expect(subject).to belong_to(:user)}
    it {expect(subject).to belong_to(:credit_card)}
    it {expect(subject).to have_many(:order_items)}
    it {expect(subject).to have_one(:billing_address)}
    it {expect(subject).to have_one(:shipping_address)}

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
      let(:book) {FactoryGirl.create :product}
      let(:other_book) {FactoryGirl.create :product}
      let(:product_ordered) {FactoryGirl.create :order_item, product: book, price: book.price}
      let(:other_product) {FactoryGirl.create :order_item, product: other_book, price: other_book.price}
      it "add product when other product is already ordered" do
        subject.add product_ordered
        expect{subject.add other_product}.to change{subject.order_items.count}.by(1)
      end
      it "add product when it is not yet ordered" do
        expect{subject.add product_ordered}.to change{subject.order_items.count}.by(1)
      end
      it "add product when it is already ordered" do
        subject.add product_ordered
        product_ordered.quantity = 3
        subject.add product_ordered
        expect(subject.order_items.first.quantity).to eq(3)
      end
    end

    context "#real_price" do
      let(:book) {FactoryGirl.create :product}
      let(:product_ordered) {FactoryGirl.create :order_item, product: book, price: book.price}

      it "calculate to price for order when add one product" do
        subject.add product_ordered
        expect(subject.real_price).to eq(50)
      end
      it "change #total_price" do
        subject.add product_ordered
        expect{subject.real_price}.to change{subject.total_price}.from(0).to(50)
      end
    end
  end
end
