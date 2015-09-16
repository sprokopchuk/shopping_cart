require 'spec_helper'
module ShoppingCart
  RSpec.describe CartController, type: :controller do
    routes { ShoppingCart::Engine.routes }
    let(:order_in_progress) {FactoryGirl.build_stubbed :order, user: authenticated_user}
    let(:authenticated_user) {FactoryGirl.create :user}
    let(:order_item) {FactoryGirl.build_stubbed :order_item}
    let(:order_params) {{"order_items_attributes" => {"0" => {"id" => order_item.id.to_s, "quantity" => order_item.quantity.to_s}}}}

    before(:each) do
      request.env["HTTP_REFERER"] = "localhost:3000/where_i_came_from"
      allow(controller).to receive(:current_cart).and_return order_in_progress
      allow(controller).to receive(:current_user).and_return authenticated_user
    end

    describe 'GET #show' do

      it "renders :show template" do
        get :show
        expect(response).to render_template :show
      end
    end

    describe "PUT #update" do


      context "with valid attributes" do
        before do
          allow(order_in_progress).to receive(:update).and_return true
        end

        it "receives update for @current_order" do
          expect(order_in_progress).to receive(:update).with(order_params)
          put :update, order: order_params
        end

        it "sends success notice" do
          put :update, order: order_params
          expect(flash[:notice]).to eq(I18n.t("current_order.update_success"))
        end

        it "redirects to shopping cart" do
          put :update, order: order_params
          expect(response).to redirect_to(:back)
        end

      end

      context "with invalid attributes" do

        before do
          allow(order_in_progress).to receive(:update).and_return false
          put :update, order: order_params
        end

        it "sends fail message" do
          expect(flash[:notice]).to eq(I18n.t("current_order.fail"))
        end
        it "redirects to :back when attempt to update is fail" do
          expect(response).to redirect_to :back
        end
      end
    end
  end
end
