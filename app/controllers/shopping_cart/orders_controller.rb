require_dependency "shopping_cart/application_controller"

module ShoppingCart
  class OrdersController < ApplicationController
    load_and_authorize_resource

    add_breadcrumb (I18n.t"orders.orders"), :orders_path

    def index
    end

    def show
      add_breadcrumb (I18n.t("orders.show.order_number", number: @order.number)), @orders
    end


  end
end
