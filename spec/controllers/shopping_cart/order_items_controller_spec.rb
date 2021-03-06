require 'spec_helper'
module ShoppingCart
  RSpec.describe OrderItemsController, type: :controller do
    routes { ShoppingCart::Engine.routes }
    let(:authenticated_user) {FactoryGirl.create :user}
    let(:ability) { Ability.new(authenticated_user) }
    let(:book) {FactoryGirl.create :book}
    let(:order_in_progress) {FactoryGirl.create :order, user: authenticated_user}
    let(:order_item) {FactoryGirl.build_stubbed :order_item_with_book}
    let(:order_item_params) {FactoryGirl.attributes_for(:order_item, cartable_id: book.id, cartable_type: book.class.to_s).stringify_keys}
    before(:each) do
      request.env["HTTP_REFERER"] = "localhost:3000/where_i_came_from"
      allow(controller).to receive(:current_ability).and_return(ability)
      allow(controller).to receive(:current_cart).and_return order_in_progress
      ability.can :manage, :all
    end
    describe 'POST #create' do
      before do
        allow(OrderItem).to receive(:new).and_return order_item
        allow(order_item).to receive(:==).and_return true
      end
      context "with valid attributes" do
        before do
          allow(controller).to receive_message_chain(:current_cart, :add).and_return true
        end

        it "assigns @order_item" do
          post :create, order_item: order_item_params
          expect(assigns(:order_item)).not_to be_nil
        end

        it "receives add for current_cart" do
          expect(order_in_progress).to receive(:add).with(book, order_item.quantity.to_s)
          post :create, order_item: order_item_params
        end

        it "sends success notice" do
          post :create, order_item: order_item_params
          expect(flash[:notice]).to eq I18n.t("order_items.add_success")
        end

        it "redirects to back" do
          post :create, order_item: order_item_params
          expect(response).to redirect_to :back
        end
      end
      context "with invalid attributes" do
        before do
          allow(controller).to receive_message_chain(:current_cart, :add).and_return false
        end

        it "rsends fail notice" do
          post :create, order_item: order_item_params
          expect(flash[:notice]).to eq I18n.t("order_items.add_fail")
        end

        it "redirects to back" do
          post :create, order_item: order_item_params
          expect(response).to redirect_to :back
        end
      end

      context "without ability to create" do
        before do
          ability.cannot :create, OrderItem
        end

        it "redirects to root path" do
          post :create, order_item: order_item_params
          expect(response).to redirect_to main_app.root_path
        end
      end
    end

    describe 'DELETE #destroy' do
      before do
        allow(OrderItem).to receive(:find).and_return order_item
        allow(order_item).to receive(:destroy).and_return true
      end

      it "sends success notice destroy item" do
        delete :destroy, id: order_item.id
        expect(flash[:notice]).to eq I18n.t("order_items.destroy_item")
      end

      it "redirects to :back" do
        delete :destroy, id: order_item.id
        expect(response).to redirect_to :back
      end

      context "without ability to destroy" do
        before do
          ability.cannot :destroy, OrderItem
        end

        it "redirects to root path" do
          delete :destroy, id: order_item.id
          expect(response).to redirect_to main_app.root_path
        end
      end
    end

    describe "POST #destroy_all" do
      before do
        allow(controller).to receive_message_chain(:current_cart, :order_items, :destroy_all).and_return [order_item]
      end
      it "sends success notice destroy all items" do
        post :destroy_all
        expect(flash[:notice]).to eq I18n.t("order_items.destroy_all_items")
      end

      it "redirects to :back" do
        post :destroy_all
        expect(response).to redirect_to :back
      end

      context "without ability to destroy all" do
        before do
          ability.cannot :destroy_all, OrderItem
        end

        it "redirects to root path" do
          post :destroy_all
          expect(response).to redirect_to main_app.root_path
        end
      end
    end
  end
end
