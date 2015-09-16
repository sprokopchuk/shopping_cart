
module ShoppingCart
  class CartController < ApplicationController

    def show
      current_cart
    end

    def update
      if current_cart.update(order_params)
        redirect_to :back, notice: t("current_order.update_success")
      else
        redirect_to :back, notice: t("current_order.fail")
      end
    end


    private

    def order_params
      params.require(:order).permit(:order_items_attributes => [:id, :quantity])
    end

  end
end
