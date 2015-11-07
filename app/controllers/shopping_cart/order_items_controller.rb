
module ShoppingCart
  class OrderItemsController < ApplicationController

    include ActiveSupport::Notifications

    load_and_authorize_resource

    class NotAsCartable < StandardError
    end

    rescue_from NotAsCartable, :with => :not_as_cartable

    def not_as_cartable(exception)
      flash[:notice] = "This product don't acts as cartable"
      Event.new "Exception: #{exception.message}", cartable_class.to_s, request.remote_ip
      redirect_to "/"
    end

    def create
      raise NotAsCartable unless ShoppingCart::Cartable.cartables.include?(cartable_class.to_s)
      product = cartable_class.find(params[:order_item][:cartable_id])
      if current_cart.add product, params[:order_item][:quantity]
        redirect_to :back, notice: t("order_items.add_success")
      else
        redirect_to :back, notice: t("order_items.add_fail")
      end
    end

    def destroy
      @order_item.destroy
      redirect_to :back, notice: t("order_items.destroy_item")
    end

    def destroy_all
      @order_items.destroy_all
      redirect_to :back, notice: t("order_items.destroy_all_items")
    end

    private

    def cartable_class
      params[:order_item][:cartable_type].constantize
    end

  end
end

